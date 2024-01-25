puts "Enter the ratio a:"
a = gets.chomp.to_f

puts "Enter the ratio b:"
b = gets.chomp.to_f

puts "Enter the ratio c:"
c = gets.chomp.to_f

discriminant = b**2 - 4 * a * c

puts "Discriminant: #{discriminant}"

if discriminant > 0
  x_1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  x_2 = (-b - Math.sqrt(discriminant)) / (2 * a)
  puts "Roots: x_1 = #{x_1}, x_2 = #{x_2}"
elsif discriminant == 0
  x = -b / (2 * a)
  puts "Root: x = #{x}"
else
  puts "No real roots"
end