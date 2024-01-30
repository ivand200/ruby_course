# Заполнить массив числами фибоначчи до 100.

fibonacci = [0, 1]
while fibonacci[-1] + fibonacci[-2] <= 100
  next_fibonacci = fibonacci[-1] + fibonacci[-2]
  fibonacci << next_fibonacci
end

puts fibonacci