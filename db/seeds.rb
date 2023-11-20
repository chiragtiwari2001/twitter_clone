# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Admin User
admin_user = User.new(
  username: 'Admin User',
  email: 'admin@example.com',
  password: 'admin_password',
  password_confirmation: 'admin_password',
)

admin_user.skip_confirmation!
admin_user.add_role :admin
admin_user.save

# Creating Stripe Id for Admin
stripe_customer = Stripe::Customer.create(
  email: admin_user.email
)

# Updating Admin User
admin_user.update(stripe_customer_id: stripe_customer.id)

#Example User
5.times do |n|
  user = User.new(
    username: "User#{n + 1}",
    email: "user#{n + 1}@example.com",
    password: 'password',
    password_confirmation: 'password',
  )
  user.skip_confirmation!
  user.save
end

#Simple User
simple_user = User.new(
  username: "Simple User",
  email: "simpleuser@example.com",
  password: "simple_user",
  password_confirmation: "simple_user"
)
simple_user.skip_confirmation!
simple_user.save

#Post Example
post1 = admin_user.posts.create(content: "Hello everyone!")
post2 = simple_user.posts.create(content: "good morning!")

image_path = Rails.root.join('app', 'assets', 'images','App_Logo.png')
post1.images.attach(io: File.open(image_path), filename: 'App_Logo.png', content_type: 'image/png')

#Admin User following
admin_user.following << simple_user
