require 'rails_helper'

RSpec.feature "Visitor navigates to home page and click 'Add' button on a product", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(name: Faker::Hipster.sentence(3),
                                 description: Faker::Hipster.paragraph(4),
                                 image: open_asset('apparel1.jpg'),
                                 quantity: 10,
                                 price: 64.99)
    end
  end

  scenario 'My Cart (0) should change to My Cart (1)' do
    visit root_path
    first('.product footer a').click

    expect(page).to have_text 'My Cart (1)'
    save_screenshot
  end

end
