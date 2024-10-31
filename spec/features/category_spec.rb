require 'rails_helper'

RSpec.feature "Category", type: :feature do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let!(:category) { FactoryBot.create(:category, name: 'Beverages') }
  let!(:category_edit) { FactoryBot.create(:category, name: 'Desserts') }

  before do
    log_in(as: admin)
    visit categories_path
  end

  scenario "Displaying categories" do
    expect(page).to have_content(category.name)
    expect(page).to have_content(category_edit.name)
  end

  scenario "Deleting a category" do

    within('.unit', text: category.name) do
      click_button 'Delete'
    end

    expect(page).to_not have_content(category.name)
  end

  scenario "Creating a new category" do
    click_link 'New Category'

    fill_in 'category_name', with: 'Foo!'
    find('input[value="Create Category"]', match: :first).click

    expect(page).to have_content('Foo!')
  end

  scenario "Editing an existing category" do
    within('.unit', text: category_edit.name) do
      click_link 'Edit Category'
    end

    category_name = find('input[id="category_name"]', visible: true)
    expect(category_name.value).to eq(category_edit.name)

    fill_in 'category_name', with: 'Edited!'
    find('input[value="Update Category"]', visible: true).click

    expect(page).to have_content('Edited!')
  end
end
