# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер
# буквы в алфавите (a - 1).

vowels = "aeiou"
alphabet = ("a".."z").to_a
vowel_hash = {}

vowels.each_char do |vowel|
  vowel_hash[vowel] = alphabet.index(vowel) + 1
end

puts vowel_hash