require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'should have a name' do
      @product = Product.new(name: 'test product')
      expect(@product.name).to be_truthy
    end

    it 'should have a price' do
      @product = Product.new(name: 'test product', price: 1000)
      expect(@product.price).to be_truthy
    end

    it 'should have a quantity' do
      @product = Product.new(name: 'test product', price: 1000, quantity: 100)
      expect(@product.quantity).to be_truthy
    end

    it 'should have a category' do
      @category = Category.new(name: 'test category')
      @product = Product.new(name: 'test product', price: 1000, quantity: 100, category: @category)
      expect(@product.category).to be_truthy
    end
  end
end
