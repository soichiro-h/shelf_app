# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user validation' do
    subject(:user) { User.new(nickname: 'a' * 12, email: 'user@test.com', password: 'pass06') }

    it 'valid user' do
      expect(user).to be_valid
    end

    it 'invalid nickname (blank)' do
      user.nickname = ' '
      expect(user).not_to be_valid
    end

    it 'invalid nickname (more than 13 ltrs)' do
      user.nickname = 'a' * 13
      expect(user).not_to be_valid
    end

    it 'invalid password (blank)' do
      user.password = ' '
      expect(user).not_to be_valid
    end

    it 'invalid password (less than 5 ltrs)' do
      user.password = 'a' * 5
      expect(user).not_to be_valid
    end

    it 'invalid email (blank)' do
      user.email = ' '
      expect(user).not_to be_valid
    end

    it 'invalid email (wrong format)' do
      user.email = 'test@'
      expect(user).not_to be_valid
    end

    it 'invalid email (duplicated)' do
      user.save
      another_user = User.new(email: user.email, nickname: 'test', password: 'password')
      expect(another_user).not_to be_valid
    end
  end
end
