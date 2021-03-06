numbers = [1,2,3,4]
sum = 0
numbers.each do |n|
  sum_value = n.even? ? n*10:n
  sum += sum_value
end
puts sum

# --- 配列や文字列の一部を抜き出す ---
a = [1,2,3,4,5]
puts a[1..3]
a = 'abcdef'
puts a[1..3]

# --- n以上m以下、n以上m未満の判定をする ---
def liquid?(temperature)
  (0...100).include?(temperature)
end
puts liquid?(50)

# --- case文で使う ---
def charge(age)
  case age
  when 0..5
    0
  when 6..12
    300
  when 13..18
    600
  else
    1000
  end
end

puts charge(3)
puts charge(12)
puts charge(16)
puts charge(25)

# 4.5.4 値が連続する配列を作成する ---
puts (1..5).to_a
puts (1...5).to_a
puts "splat展開"
puts [*1..5]
puts [*1...5]

# 4.5.5 繰り返し処理を行う ---
numbers = (1..4).to_a
sum = 0
numbers.each {|n| sum += n}
puts sum
## 範囲オブジェクトに対して直接eachメソッドを呼び出す
sum = 0
(1..4).each {|n| sum += n}
puts sum
## stepメソッドで値を増やす間隔を指定できる
numbers = []
### 1から10まで2つ飛ばしで繰り返し処理を行う
(1..10).step(2) {|n| numbers << n}
puts numbers

# 4.7.1 さまざまな要素の取得方法 ---
a = [1,2,3,4,5]
puts a[1,3]
puts ""
puts a.values_at(0,2,4)
puts a[a.size - 1]
puts ""
puts a.last
puts a.last(2)
puts
puts a.first
puts a.first(2)
puts

# 4.7.2 様々な要素の変更方法 ---

a = [1,2,3]
a[-3] = -10
puts a[-3]
a = [1,2,3,4,5]
a[1,3] = 100
puts a
a = []
a.push(1)
a.push(2,3)
puts a
puts
a = [1,2,3,1,2,3]
a.delete(2)
puts a
a.delete(5)

puts
# 4.7.3 配列の連結 ---

a = [1]
b = [2,3]
a.concat(b)
puts a
puts b
puts
a = [1]
b = [2,3]
a + b
puts a
puts b
puts

# 4.7.4 配列の和集合、差集合、積集合 ---
a = [1,2,3]
b = [3,4,5]
puts a | b
puts
puts a - b
puts
puts a & b
puts
require 'set'
a = Set.new([1,2,3])
b = Set.new([3,4,5])
puts a | b
puts
puts a - b
puts
puts a & b
puts
puts "4.7.5 多重代入で残りの全要素を配列として受け取る ---"
e,f = 100,200,300
puts e
puts f
puts
e,*f = 100,200,300
puts e
puts f
puts
puts "4.7.6 1つの配列を複数の因数として展開する ---"
a = []
b = [2,3]
puts a.push(1)
puts a.push(b)
puts
puts a.push(*b)
puts
puts "4.7.7 メソッドの可変長引数 ---"
def greeting(*names)
  "#{names.join('と')}, こんにちは！ "
end
puts greeting('田中さん')
puts greeting('田中さん','鈴木さん')
puts greeting('田中さん','鈴木さん','佐藤さん')
puts
puts "4.7.8 *で配列同士を非破壊的に連結する ---"
a = [1,2,3]
puts [-1,0,*a,4,5]
puts
puts [-1,0] + a + [4,5]
puts
puts "4.7.9 ==で等しい配列かどうか判断する ---"
puts [1,2,3] == [1,2,3]
puts [1,2,3] == [1,2]
puts
puts "4.7.10 %記法で文字列の配列を簡潔に作る ---"
puts ['apple', 'melon', 'orange']
puts
puts %w!apple melon orange!
puts
puts %w(apple melon orange)
puts
puts %w(big\ apple small\ melon orange)
puts
prefix = 'This is'
puts %W(#{prefix}\ an\ apple small\nmelon orange)
puts
puts "4.7.11 文字列を配列に変換する ---"
puts 'Ruby'.chars
puts 'Ruby,Java,Perl,PHP'.split(',')
puts
puts "4.7.12 配列に初期値を設定する ---"
a = Array.new(5,0)
puts a
puts
a = Array.new(10) {|n|n % 3 + 1 }
puts a
puts
puts "4.7.13 配列に初期値を設定する場合の注意点 ---"
a = Array.new(5, 'default')
puts a
puts
str = a[0]
puts str
str.upcase!
puts str
puts
puts a
puts
a = Array.new(5) {'default'}
puts a
puts
str = a[0]
puts str
puts
str.upcase!
puts str
puts
puts a
puts
puts "4.7.14 ミュータブル？　イミュータブル？"
a = Array.new(5, 0)
print a
puts
n = a[0]
print n
puts
# 4.8 ブロックについてもっと詳しく
puts "4.8.1 添え字付きの繰り返し処理 ---"
fruits = ['apple', 'orange', 'melon']
fruits.each_with_index{ |fruit, i| puts "#{i}: #{fruit}" }
puts
puts "4.8.2 with_indexメソッドを使った添え字付きの繰り返し処理 ---"
puts print fruits.map.with_index{ |fruit, i| "#{i}: #{fruit}" }
puts print fruits.delete_if.with_index {|fruit, i| fruit.include?('a') && i.odd? }
puts
puts "4.8.3 添え字を0以外の数値から開始させる ---"
fruits = ['apple', 'orange', 'melon']
fruits.each.with_index(1) {|fruit, i| puts "#{i}: #{fruit}" }
puts
puts print fruits.map.with_index(10) {|fruit, i| "#{i}: #{fruit}" }
puts
puts "4.8.4 配列がブロック引数に渡される場合 ---"
dimensions = [
  [10,20],
  [30,40],
  [50,60]
]
areas = []
# dimensions.each do |dimension|
#   length = dimension[0]
#   width = dimension[1]
#   areas << length * width
# end
dimensions.each do |length, width|
  areas << length * width
end
puts print areas
puts

dimensions.each do |length, width, foo, bar|
  p [length, width, foo, bar]
end
puts

dimensions.each_with_index do |(length, width), i|
  puts "length: #{length}, width: #{width}, i: #{i}"
end
puts

puts "4.8.5 ブロックローカル変数 ---"
numbers = [1,2,3,4]
sum = 0
numbers.each do |n; sum|
  sum = 10
  sum += n
  p sum
end
puts print sum
puts

puts "4.8.6 繰り返し処理以外でも使用されるブロック ---"
File.open("./sample.txt", "w") do | file |
  file. puts(" 1 行 目 の テキスト です。")
  file. puts(" 2 行 目 の テキスト です。")
  file. puts(" 3 行 目 の テキスト です。")
end
puts

puts "4.8.7 do...endと{}の結合度の違い ---"
a = [1,2,3]
puts print a.delete(100)
a.delete (100) {puts print 'NG'}
puts

puts "4.8.8 ブロックを使うメソッドを定義する ---"
names =['田中', '鈴木', '佐藤']
san_names = names.map {|name| "#{name}さん"}.join('と')
puts print san_names
puts
names.map do |name|
  "#{name}さん"
end.join('と')
puts

# 4.9 さまざまな繰り返し処理
puts "4.9.1 timesメソッド ---"
sum = 0
5.times {|n| sum += n}
puts print sum
puts
sum = 0
5.times {sum += 1}
puts print sum
puts

puts "4.9.2 uptoメソッドとdowntoメソッド ---"
a = []
10.upto(14) {|n| a << n }
puts print a
14.downto(10) {|n| a << n }
puts print a
puts

puts "4.9.3 stepメソッド ---"
a = []
1.step(10, 2) {|n| a << n }
puts print a
a = []
10.step(1, -2) {|n| a << n }
puts print a
puts

puts "4.9.4 while文とuntil文 ---"
a = []
while a.size < 5
  a << 1
end
puts print a

a = []
while a.size < 5 do a << 1 end
puts print a

a = []
a << 1 while a.size < 5
puts print a

a = []
begin
  a << 1
end while false
puts print a
puts

a = [10, 20, 30, 40, 50]
until a.size <= 3
  a.delete_at(-1)
end
puts print a
puts

puts "4.9.5 for文 ---"
numbers = [1, 2, 3, 4]
sum = 0
for n in numbers do sum += n end
puts print sum
puts

numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum_value = n.even? ? n * 10 : n
  sum + sum_value
end
puts print n
# puts print sum_value
puts

sum = 0
for n in numbers do
  sum_value = n.even? ? n * 10 : n
  sum + sum_value
end
puts print n
puts print sum_value
puts

puts "4.9.6 loopメソッド ---"
numbers = [1, 2, 3, 4, 5]
loop do
  n = numbers.sample
  puts n
  break if n == 5
end
puts

# 4.10繰り返し処理用の制御構造
puts "4.10.1 break ---"
numbers = [1 ,2 ,3 ,4 ,5].shuffle
numbers.each do |n|
  puts n
  break if n == 5
end
puts

numbers = [1 ,2 ,3 ,4 ,5].shuffle
i = 0
while i < numbers.size
  n = numbers[i]
  puts n
  break if n == 5
  i += 1
end
puts

ret =
  while true
    break 123
  end
puts ret
puts

fruits = ['apple', 'melon', 'orange']
numbers = [1, 2, 3]
fruits.each do |fruit|
  numbers.shuffle.each do |n|
    puts "#{fruit}, #{n}"
    break if n == 3
  end
end
puts

puts "4.10.2 throwとcatchを使った大域脱出 ---"
fruits = ['apple', 'melon', 'orange']
numbers = [1, 2, 3]
catch :done do
  fruits.each do |fruit|
    numbers.shuffle.each do |n|
      puts "#{fruit}, #{n}"
      if fruit == 'orange' && n == 3
        throw :done
      end
    end
  end
end
puts

ret =
  catch :done do
    throw :done, 123
  end
puts ret
puts

puts "4.10.3 繰り返し処理で使うbreakとreturnの違い ---"
def calc_with_return
  numbers = [1, 2, 3, 4, 5, 6]
  target = nil
  numbers.shuffle.each do |n|
    target = n
    return if n.even?
  end
  target * 10
end
puts calc_with_return
puts

puts "4.10.4 next ---"
numbers = [1, 2, 3, 4, 5]
numbers.each do |n|
  next if n.even?
  puts n
end
puts

i = 0
while i < numbers.size
  n = numbers[i]
  i += 1
  next if n.even?
  puts n
end
puts

fruits = ['apple', 'melon', 'orange']
numbers = [1, 2, 3, 4]
fruits.each do |fruit|
  numbers.each do |n|
    next if n.even?
    puts "#{fruit}, #{n}"
  end
end
puts

puts "4.10.5 redo ---"
foods = ['ピーマン', 'トマト', 'セロリ']
count = 0
foods.each do |food|
  print "#{food}は好きですか？ =>"
  answer = 'いいえ'
  puts answer
  count += 1
  redo if answer != 'はい' && count < 2
  count = 0
end