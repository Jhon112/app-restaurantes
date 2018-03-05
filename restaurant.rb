require_relative "menu"
require_relative "order"
require_relative "checkout"

class Restaurant
  include Menu
  include Order
  include Checkout

  attr_reader :menu, :orders_queue, :order, :checkout

  def initialize
    @menu = Menu.new
    @orders_queue = OrderQueue.new
    @checkout = Checkout.new
  end

  def create_order
    return "orden en proceso" if @order
    @order = Order.new(@orders_queue.orders.length + 1)
  end

  def add_product_to_order(code, quantity)
    product = @menu.find_product(code)
    return unless product
    @order.add_item(product, quantity)
  end

  def add_order_to_queue
    @orders_queue.add_order(@order)
    @order = nil
  end

  def pay_order(id)
    order_to_pay = @orders_queue.orders[id]
    if order_to_pay
      @checkout.pay_order(order_to_pay)
      @orders_queue.orders.delete(id)
    else
      puts "No existe la orden"
    end
  end
end

restaurant = Restaurant.new
restaurant.menu.show_products
restaurant.create_order
restaurant.add_product_to_order("prod1", 2)
restaurant.add_product_to_order("prod2", 3)
restaurant.add_product_to_order("prod3", 4)
restaurant.add_order_to_queue

restaurant.create_order
restaurant.add_product_to_order("prod2", 2)
restaurant.add_product_to_order("prod6", 1)
restaurant.add_order_to_queue

restaurant.create_order
restaurant.add_product_to_order("prod2", 2)
restaurant.add_product_to_order("prod6", 1)
restaurant.add_order_to_queue

restaurant.pay_order(1)
restaurant.pay_order(2)

restaurant.orders_queue.show_orders
restaurant.checkout.show_paid_orders_details
