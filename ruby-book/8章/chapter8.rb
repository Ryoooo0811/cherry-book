< 第8章 モジュールを理解する >
! 8.1 イントロダクション
-- 8.1.1 この章の例題：deep_freezeメソッド
# class Team
#   # COUNTRIES = ['Japan', 'US', 'India'].freeze
#   COUNTRIES = ['Japan'.freeze, 'US'.freeze, 'India'.freeze].freeze
# end
上記のように全てにfreezeをつけるのは面倒だ

# class Team
#   COUNTRIES = deep_freeze(['Japan', 'US', 'India'])
# end
# Team::COUNTRIES.frozen? => true
# Team::COUNTRIES.all?{|country| country.frozen?} => true

# class Bank
#   CURRENCIES = deep_freeze({'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee'})
# end
# Bank::CURRENCIES.frozen? => true
# Bank::CURRENCIES.all?({|key, value| key.frozen? && value.frozen?}) => true

-- 8.1.2 この章で学ぶこと
・モジュールの概要
・モジュールのミックスイン(includeとextend)
・モジュールを利用した名前空間の作成
・関数や定数を提供するモジュールの作成
・状態を保持するモジュールの作成
・モジュールに関する高度な話題

! 8.2 モジュールの概要
-- 8.2.1 モジュールの用途
・継承を使わずにクラスにインスタンスメソッドを追加する、もしくは上書きする(ミックスイン)。
・複数のクラスに対して共通のお特異メソッド(クラスメソッド)を追加する(ミックスイン)。
・クラス名や定数名の衝突を防ぐために名前空間を作る。
・関数的メソッドを定義する。
・シングルトンオブジェクトのように扱って設定値などを保持する。

-- 8.2.2 モジュールの定義
# module Greeter
#   def hello
#     'hello'
#   end
# end
# module AwesomeGreeter < Greeter
# end   => syntax error, unexpected '<' (SyntaxError)

! 8.3 モジュールのミックスイン(includeとextend)
-- 8.3.1 モジュールをクラスにincludeする
# module Loggable
#   private
#   def log(text)
#     puts "[LOG] #{text}"
#   end
# end

# class Product
#   include Loggable
#   def title
#     log 'title is called.'
#     'A great movie'
#   end
# end

# class User
#   include Loggable
#   def name
#     log 'name is called.'
#     'Alice'
#   end
# end
# product = Product.new
# product.title
# user = User.new
# user.name

-- 8.3.2 モジュールをextendする
# module Loggable
#   def log(text)
#     puts "[LOG] #{text}"
#   end
# end

# class Product
#   extend Loggable
#   def self.create_products(names)
#     log 'create_products is called.'
#   end
# end
# Product.create_products([])
# Product.log('Hello.')

! 8.4 例題：deep_freezeメソッドの作成
-- 8.4.1 実装の方針を検討する
# module DeepFreezable
#   def deep_freeze(array_or_hash)
    
#   end
# end

# class Team
#   extend DeepFreezable
#   COUNTRIES = deep_freeze(['Japan', 'US', 'India'])
# end

# class Bank
#   extend DeepFreezable
#   CURRENCIES = deep_freeze({'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee'})
# end

-- 8.4.2 テストコードを準備する
・deep_freezable_test.rbを作成する
・deep_freezable.rbを作成する

-- 8.4.3 deep_freezeメソッドを実装する
・team.rbを作成する
・bank.rbを作成する

-- 8.4.4 deep_freezeメソッドをハッシュ対応させる
・テストコードを入力

! 8.5 ミックスインについてもっと詳しく
-- 8.5.1 includeされたモジュールの有無を確認する
# module Loggable
  
# end

# class Product
#   include Loggable
# end
# Product.include?(Loggable)
# Product.included_modules
# product = Product.new
# product.is_a?(Product)
# product.class.included_modules

-- 8.5.2 include先のメソッドを使うモジュール
# module Taggable
#   def  price_tag
#     # priceメソッドはinclude先で定義されているはずという前提
#     "#{price}円"
#   end
# end

# class Product
#   include Taggable
#   def price
#     1000
#   end
# end
# product = Product.new
# product.price_tag

-- 8.5.3 Enumerableモジュール
Array.include?(Enumerable)
Hash.include?(Enumerable)
Range.include?(Enumerable)

[1,2,3].map{|n| n*10}
{a: 1, b: 2, c: 3}.map{|k, v|[k, v *10]}
(1..3).map{|n| n *10}
[1,2,3].count
{a: 1, b: 2, c: 3}.count
(1..3).count

-- 8.5.4 Comparableモジュールと<=>演算子
2 <=> 1
2 <=> 2
1 <=> 2
2 <=> 'abc'

# class Tempo
#   include Comparable
#   attr_reader :bpm
#   def initialize(bpm)
#     @bpm = bpm
#   end

#   def <=>(other)
#     if other.is_a?(Tempo)
#       bpm <=> other.bpm
#     else
#       nil
#     end
#   end

#   def inspect
#     "#{bpm}bpm"
#   end
# end
# t_120 = Tempo.new(120)
# t_180 = Tempo.new(180)

# t_120 > t_180
# t_120 <= t_180
# t_120 == t_180

-- 8.5.5 Kernelモジュール
            BasicObject
                 ↑      include
              Object--------------->Kernelモジュール
  _______________↑_____________
  |          |         |       |
String    Numeric    Array    Hash

-- 8.5.6 トップレベルはmainという名前のObject
# p self
# p self.class
# class User
#   p self
#   p self.class
# end

--8.5.7 クラスやモジュール自身もオブジェクト
# class User
#   p self
#   p self.class
# end

# module Loggable
#   p self
#   p self.class
# end

-- 8.5.8 モジュールとインスタンス変数
# module NameChanger
#   def change_name
#     # include先のクラスのインスタンス変数を変更する
#     # @name = 'ありす'

#     # セッターメソッド経由でデータを変更する
#     self.name = 'ありす'
#   end
# end

# class User
#   include NameChanger
#   # attr_reader :name

#   # ゲッターメソッドとセッターメソッドを用意する
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end
# user = User.new('alice')
# user.name
# user.change_name
# user.name

-- 8.5.9 オブジェクトに直接ミックスインする
# module Loggable
#   def log(text)
#     puts "[LOG]#{text}"
#   end
# end
# s = 'abc'
# s.log('Hello.')
# s.extend(Loggable)
# s.log('Hello.')


! 8.6 モジュールを利用した名前空間の作成
-- 8.6.1 名前空間を分けて名前の衝突を防ぐ
# module Baseball
#   # これはBaseballモジュールに属するSecondクラス
#   class Second
#     def initialize(player, uniform_number)
#       @player = player
#       @uniform_number = uniform_number
#     end
#   end
# end

# module Clock
#   # これはClockモジュールに属するSecondクラス
#   class Second
#     def initialize(digits)
#       @digits = digits
#     end
#   end
# end
# Baseball::Second.new('Alice', 13)
# Clock::Second.new(13)

-- 8.6.2 名前空間でグループやカテゴリを分ける
# require "active_ support/core_ ext/string/conversions"
# module ActiveRecord
#   module Associations
#     # Keeps track of table aliases for ActiveRecord::Associations::JoinDependency
#     class AliasTracker

-- 8.6.3 ネストなしで名前空間付きのクラスを定義する
# module Baseball
# end

# class Baseball::Second
#   def initialize(player, uniform_number)
#     @player = player
#     @uniform_number = uniform_number
#   end
# end

! 8.7 関数や定数を提供するもじゅーつの作成
-- 8.7.1 モジュールに特異メソッドを定義する
# module Loggable
#   class << self
#     def log(text)
#       puts "[LOG]#{text}"
#     end
#   end
# end
# Loggable.log('Hello')

-- 8.7.2 module_functionメソッド
# module Loggable
#   def log(text)
#     puts "[LOG]#{text}"
#   end
#   module_function :log
# end
# Loggable.log('Hello.')

# class Product
#   include Loggable
#   def title
#     log 'title is called.'
#     'A great movie'
#   end
# end
# product = Product.new
# product.title

-- 8.7.3 モジュールに定数を定義する
# module Loggable
#   # 定数を定義
#   PREFIX = '[LOG]'.freeze
#   def log(text)
#     puts "#{PREFIX} #{text}"
#   end
# end
# Loggable::PREFIX

-- 8.7.4 モジュール関数や定数を持つモジュールの例
# Math.sqrt(2)
# class Calculator
#   include Math
#   def calc_sqrt(n)
#     sqrt(n)
#   end
# end
# calculator = Calculator.new
# calculator.calc_sqrt(2)
# Math::E
# Math::PI
# Kernel.puts "Hello."
# Kernel.p [1,2,3]

! 8.8 状態を保持するモジュールの作成
# module AwesomeAPI
#   @base_url = ''
#   @debug_mode = false

#   class << self
#     def base_url=(value)
#       @base_url = value
#     end

#     def base_url
#       @base_url
#     end

#     def debug_mode=(value)
#       @debug_mode = value
#     end

#     def debug_mode
#       @debug_mode
#     end
#   end
# end
# AwesomeAPI.base_url = 'http://example.com'
# AwesomeAPI.debug_mode = true
# AwesomeAPI.base_url
# AwesomeAPI.debug_mode

! 8.9 モジュールに関する高度な話題
-- 8.9.1 メソッド探索のルールを理解する
# module A
#   def to_s
#     "<A>#{super}"
#   end
# end

# module B
#   def to_s
#     "<B>#{super}"
#   end
# end

# class Product
#   def to_s
#     "<Product>#{super}"
#   end
# end

# class DVD < Product
#   include A
#   include B
#   def to_s
#     "<DVD>#{super}"
#   end
# end
# dvd = DVD.new
# dvd.to_s
# DVD.ancestors

-- 8.9.2 モジュールにほかのモジュールをincludeする
# module Greeting
#   def hello
#     'hello'
#   end
# end

# module Aisatsu
#   include Greeting
#   def konnichiwa
#     'こんにちは。'
#   end
# end

# class User
#   include Aisatsu
# end
# user = User.new
# user.konnichiwa
# user.hello
# User.ancestors

-- 8.9.3 prependでモジュールをミックスインする
# module A
#   def to_s
#     "<A>#{super}"
#   end
# end

# class Product
#   prepend A
#   def to_s
#     "<Product>#{super}"
#   end
# end
# product = Product.new
# product.to_s

-- 8.9.4 prependで既存のメソッドを置き換える
# class Product
#   def name
#     "A great film"
#   end
# end

# module NameDecorator
#   def name
#     "<<#{super}>>"
#   end
# end

# class Product
#   prepend NameDecorator
# end

# product = Product.new
# product.name

-- 8.9.5 有効範囲を限定できるrefinements
# module StringShuffle
#   refine String do
#     def shuffle
#       chars.shuffle.join
#     end
#   end
# end

# class User
#   using StringShuffle
#   def initialize(name)
#     @name = name
#   end

#   def shuffled_name
#     @name.shuffle
#   end
# end
# user = User.new('Alice')
# user.shuffled_name

! 8.10 この章のまとめ
この章で学んだ内容
・モジュールの概要
・モジュールのミックスイン(includeとextend)
・モジュールを利用した名前空間の作成
・関数や定数を提供するモジュールの作成
・状態を保持するモジュールの作成
・モジュールに関する高度な話題
