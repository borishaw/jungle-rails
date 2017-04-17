require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validates :name, presence: true
    describe 'A product should have a name' do
      it 'should have a product name' do
        @product = Product.new(name: 'Test product')
        expect(@product.name).to be_truthy
      end
    end

    # validates :price, presence: true
    describe 'A product should have a price' do
      it 'should have a price' do
        @product = Product.new(name: 'Test product', price: 100)
        expect(@product.price).to be_truthy
      end
    end

    # validates :quantity, presence: true
    describe 'A product should have a quantity' do
      it 'should have quantity' do
        @product = Product.new(name: 'Test product', price: 100, quantity: 10)
        expect(@product.quantity).to be_truthy
      end
    end

    # validates :category, presence: true
    describe 'A product should have a category' do
      it 'should have a category' do
        @category = Category.new(name: 'Test Category')
        @product = Product.new(name: 'Test product',
                               price: 100,
                               quantity: 10,
                               category: @category)
        expect(@product.category).to be_truthy
      end
    end
  end
end
