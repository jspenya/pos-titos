module Helpers
  def log_in(as: nil)
    user = as || FactoryBot.create(:user)

    visit '/'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: FactoryBot.build(:user).password
    find('input[value="Log in"]').click

    user
  end
end
