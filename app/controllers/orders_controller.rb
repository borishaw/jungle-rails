class OrdersController < ApplicationController


  def show
    @order = Order.find(params[:id])
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, error: order.errors.full_messages.first
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, error: e.message
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_total, # in cents
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_total,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )
    cart.each do |product_id, details|
      if product = Product.find_by(id: product_id)
        quantity = details['quantity'].to_i
        order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
    end

    def send_receipt(order)
      total = order.total

      text = "Hello thank you for your order. Your total is $#{total / 100}.\n Order Detail \n"

      order.line_items.each do |i|
        text += 'Product Name: ' + i.product.name + "\n"
        text += 'Product Quantity: ' + i.product.quantity.to_s + "\n"
      end

      RestClient.post "https://api:key-47384dd877d4c2d0e670b6b27edf8e7a"\
  "@api.mailgun.net/v3/sandbox92d15394e31445768ce3d3496a59fa64.mailgun.org/messages",
                      :from => "no-reply@jungle.com",
                      :to => order.email,
                      :subject => 'Order #' + order.id.to_s,
                      :text => text
    end

    order.save!
    send_receipt(order)
    order

  end

  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0
    cart.each do |product_id, details|
      if p = Product.find_by(id: product_id)
        total += p.price_cents * details['quantity'].to_i
      end
    end
    total
  end

end
