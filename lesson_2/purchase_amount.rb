shopping_cart = {}
total_sum = 0

loop do
  puts "Enter the name of the item (or 'stop' to finish):"
  item_name = gets.chomp
  break if item_name == "stop"

  puts "Enter the unit price:"
  unit_price = gets.chomp.to_f

  puts "Enter the number of items purchased:"
  quantity = gets.chomp.to_f

  shopping_cart[item_name] = { unit_price: unit_price, quantity: quantity }
end

puts "\nShopping Cart:"
shopping_cart.each do |item, details|
  total_for_item = details[:unit_price] * details[:quantity]
  total_sum += total_for_item
  puts "#{item}: #{details[:quantity]} * #{details[:unit_price]} = #{total_for_item}"
end

puts "\nTotal sum of all purchases: #{total_sum}"