# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: 'admin@projectname.com', password: 'Password123!@#', role: 'admin' , first_name: 'Khurram', last_name: 'Sajjad', phone: '03365144430', country: 'Pakistan', confirmed_at: Time.now.utc).skip_confirmation!
