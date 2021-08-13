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

puts