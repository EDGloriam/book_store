require 'ffaker'

SECTION = ['Mobile Development', 'Photo', 'Web Design']

def rand_float
  rand(0.1..1.0).round 1
end

100.times { Author.create(name: FFaker::Book.author) }  #creation Authors
1.upto(200) do |i|
  Author.find_by(id: rand(1..100)).books.create(  #creation Books
    name: FFaker::Book.title,
    photo: FFaker::Book.cover,
    description: FFaker::Book.description,
    price: 50.00+rand(0..9),
    section: SECTION[rand(0..2)],
    publication: FFaker::Vehicle.year,
    materials: 'Hardcove, glossy paper',
    active: 'true')
  Book.find_by(id: i).create_dimension(
    h: rand_float,
    w: rand_float,
    d: rand_float)
end

Coupon.create(discount: 0.05)