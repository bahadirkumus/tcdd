# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed data for users
users = [
  {
    username: 'john_doe',
    name: 'John',
    surname: 'Doe',
    email: 'john.doe@example.com',
    password: 'Password1!',
    birthday: '1990-01-01',
    role: 'user',
    gender: 'male',
    followers_count: 10,
    following_count: 5,
    bio: 'Just a regular John Doe.',
    avatar_url: 'https://example.com/avatar/john_doe.png',
    location: 'New York, NY',
    status: 'active',
    last_seen_at: Time.now,
    confirmed_at: Time.now,
    confirmation_token: SecureRandom.hex(10),
    preferences: { theme: 'dark', notifications: true }
  },
  {
    username: 'jane_smith',
    name: 'Jane',
    surname: 'Smith',
    email: 'jane.smith@example.com',
    password: 'Password1!',
    birthday: '1992-02-02',
    role: 'admin',
    gender: 'female',
    followers_count: 20,
    following_count: 10,
    bio: 'Admin Jane Smith.',
    avatar_url: 'https://example.com/avatar/jane_smith.png',
    location: 'Los Angeles, CA',
    status: 'active',
    last_seen_at: Time.now,
    confirmed_at: Time.now,
    confirmation_token: SecureRandom.hex(10),
    preferences: { theme: 'light', notifications: false }
  }
]

users.each do |user_data|
  User.find_or_create_by!(username: user_data[:username]) do |user|
    user.update!(user_data)
  end
end
