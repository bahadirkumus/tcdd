require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         surname: '',
                                         username: '',
                                         email: 'invalidemail',
                                         password: 'foo',
                                         password_confirmation: 'foo',
                                         birthday: '',
                                         gender: '',
                                         bio: '',
                                         avatar_url: '',
                                         location: '',
                                         status: '' } }
    end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Example',
                                         surname: 'User',
                                         username: 'exampleuser',
                                         email: 'user@gmail.com',
                                         password: 'Password1!',
                                         password_confirmation: 'Password1!',
                                         birthday: '1990-01-01',
                                         gender: 'male',
                                         bio: 'This is a bio.',
                                         avatar_url: 'https://example.com/avatar.png',
                                         location: 'Somewhere',
                                         status: 'active' } }
      puts @response.body
    end
    # follow_redirect!
    # assert_template 'users/show'
    # assert is_logged_in?
  end
end
