puts "What is your name? "
user_name = gets.chomp
puts "What is your height(cm)? "
user_height = gets.chomp

user_perfect_weight = ( user_height.to_i - 110 ) * 1.15
if user_perfect_weight < 0
  puts "#{user_name}, your weight is optimal for your height."
else
  puts "#{user_name}, your perfect weight is #{user_perfect_weight}"
end
