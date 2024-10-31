require 'rails_helper'

RSpec.feature "Category", type: :feature do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let!(:category) { FactoryBot.create(:category, name: 'Beverage') }

  before { log_in(as: admin) }

  scenario "User deletes a category" do
    visit categories_path

    within('.unit', match: :first) do
      click_button 'Delete'
    end

    expect(page).to_not have_content(category.name)
  end
end
