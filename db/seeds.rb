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
    preferences: { theme: 'light', notifications: false }
  }
]

users.each do |user_data|
  user = User.find_or_initialize_by(username: user_data[:username])
  user.assign_attributes(
    email: user_data[:email],
    password: user_data[:password],
    password_confirmation: user_data[:password],
    status: user_data[:status],
    confirmed_at: user_data[:confirmed_at]
  )
  user.skip_confirmation! # Skip confirmation if you want to bypass email confirmation
  user.save!

  profile = user.profile || user.build_profile
  profile.assign_attributes(
    name: user_data[:name],
    surname: user_data[:surname],
    birthday: user_data[:birthday],
    gender: user_data[:gender],
    bio: user_data[:bio],
    avatar_url: user_data[:avatar_url],
    location: user_data[:location],
    followers_count: user_data[:followers_count],
    following_count: user_data[:following_count],
    last_seen_at: user_data[:last_seen_at],
    preferences: user_data[:preferences]
  )
  profile.save!
end
