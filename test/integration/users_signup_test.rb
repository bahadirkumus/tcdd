require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         surname: '',
                                         username: '',
                                         email: 'invlaidma@il',
                                         password: 'foo',
                                         password_confirmation: 'foo' } }
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
                                         password_confirmation: 'Password1!' } }
    end
  end
end
