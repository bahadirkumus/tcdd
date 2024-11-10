class Session
  include ActiveModel::Model
  attr_accessor :login, :password, :remember_me
end
