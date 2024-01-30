def leap_year?(year)
  (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

def ordinal_date(day, month, year)
  days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  days_in_month[1] = 29 if leap_year?(year)

  ordinal = day
  (0...month-1).each { |m| ordinal += days_in_month[m] }
  ordinal
end

puts "Enter day:"
day = gets.to_i
puts "Enter month:"
month = gets.to_i
puts "Enter year:"
year = gets.to_i

puts "The ordinal date is: #{ordinal_date(day, month, year)}"