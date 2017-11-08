require 'ffaker'
puts "**  Seeding Database: seeding ***\n\n"

puts "**  Creating Categories ***\n\n"
CATEGOTIES = %w(Mobile Development Photo Web\ Design)
CATEGOTIES.each { |category| Category.create(name: category) }

def rand_float
  rand(0.1..1.0).round 1
end

puts "**  Creating authors ***\n\n"
100.times { Author.create(name: FFaker::Book.author) } # creation Authors

puts "**  Creating books ***\n\n"
1.upto(200) do
  Book.create(
    name: FFaker::Book.title,
    description: FFaker::Book.description,
    price: rand(10..50) + rand(0.1..0.9).round(2),
    category_id: Category.ids.sample,
    publicated: FFaker::Vehicle.year,
    materials: 'Hardcove, glossy paper',
    active: 'true',
    height: rand_float,
    weight: rand_float,
    depth: rand_float
  )
end

puts "**  appending authors to books ***\n\n"
Book.all.each { |book| book.authors << Author.all.sample }

5.times { |index| Book.find(index + 1).authors << Author.all.sample }
5.times { |index| Author.find(index + 1).books << Book.all.sample }


puts "**  loading images to books ***\n\n"
@images = Dir.glob('./app/assets/images/covers/*.jpg')
@images.each { |str| str.slice!(0) }
Book.all.each_with_index do |book, i|
  img_src = File.join(Rails.root, @images[i])
  src_file = File.new(img_src)
  book.photo = src_file
  book.save
end

puts "**  create coupon ***\n\n"
Coupon.create(discount: 0.05)

puts "**  create Delivery methods ***\n\n"
Delivery.create(method: 'Delivery Next Day!', days: '1 day', price: 15)
Delivery.create(method: 'Expressit', days: '2 to 3 days', price: 10)
Delivery.create(method: 'Pick Up in-Store', days: '3 to 7 days', price: 5)

puts "**  create admin ***\n\n"
AdminUser.create!(email: 'admin@bookstore.com', password: 'adminadmin', password_confirmation: 'adminadmin')

puts "\n**  Seeding Database: completed ***\n\n"
