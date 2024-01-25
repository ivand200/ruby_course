puts "Enter the length of the first side of the triangle:"
side_1 = gets.chomp.to_f

puts "Enter the length of the second side of the triangle:"
side_2 = gets.chomp.to_f

puts "Enter the length of the third side of the triangle:"
side_3 = gets.chomp.to_f

# Check for equilateral or isosceles triangle
if side_1 == side_2 && side_2 == side_3
  puts "The triangle is equilateral."
elsif side_1 == side_2 || side_2 == side_3 || side_1 == side_3
  puts "The triangle is isosceles."
end

# Check for right-angled triangle
if (side_1 > side_2 && side_1 >side_3 && side_1 ** 2 == side_2 ** 2 + side_3 ** 2) ||
  (side_2 > side_1 && side_2 > side_3 && side_2 ** 2 == side_1 ** 2 + side_3 ** 2) ||
  (side_3 > side_1 && side_3 > side_2 && side_3 ** 2 == side_1 ** 2 + side_2 ** 2)
  puts "The triangle is right-angled."
end