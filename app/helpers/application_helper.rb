# frozen_string_literal: true

module ApplicationHelper
  def for_test_login
    @test_login_user = User.find(1)
  end

  def login_as_test_user
    user = User.find(1)
    sign_in user
    redirect_to profile_path
  end
end
