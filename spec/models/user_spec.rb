require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validation' do

    before do
      @test_user = User.new(first_name: 'John',
                            last_name: 'Smith',
                            email: 'TEST@TEST.com',
                            password: 'password',
                            password_confirmation: 'password')
      @test_user.save!
    end

    it 'must be created with a password and password_confirmation fields' do
      @user = User.new(password: 'password', password_confirmation: 'password')
      expect(@user.password && @user.password_confirmation).to be_present
    end

    it 'must have a unique email' do
      @user = User.create(first_name: 'Jane',
                          last_name: 'Smith',
                          email: 'test@test.com',
                          password: 'password',
                          password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it 'must have first_name, last_name, and email' do
      @user = User.create(password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it 'must have a password that has at least 8 digits' do
      @user = User.create(first_name: 'Jane',
                          last_name: 'Smith',
                          email: 'test@test.com',
                          password: '1234567',
                          password_confirmation: '1234567')
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @john_smith = User.new(first_name: 'John',
                             last_name: 'Smith',
                             email: 'test@test.com',
                             password: 'password',
                             password_confirmation: 'password')
      @john_smith.save!

    end

    it 'will return an instance of the user if authenticated' do
      @user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(@user == @john_smith).to be_truthy
    end

    it 'will return nil if fail to authenticate' do
      @user = User.authenticate_with_credentials('test@test.com', 'wrong_password')
      expect(@user).to be_nil
    end

    it 'should ignore casing in email' do
      @user = User.authenticate_with_credentials('test@TEST.com', 'password')
      expect(@user == @john_smith).to be_truthy
    end

    it 'should ignore preceding and trailing spaces in email' do
      @user = User.authenticate_with_credentials('   test@TEST.com   ', 'password')
      expect(@user == @john_smith).to be_truthy
    end

  end
end
