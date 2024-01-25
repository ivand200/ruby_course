puts "Please enter the base of the triangle."
triangle_base = gets.chomp
puts "Please enter the height of the triangle."
triangle_height = gets.chomp

triangle_area = (triangle_base.to_f * triangle_height.to_f) / 2.0
puts "Area of this triangle: #{triangle_area}."
