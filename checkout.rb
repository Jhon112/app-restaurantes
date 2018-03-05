module Checkout
  class Checkout
    def initialize
      @paid_orders = {}
      @total = 0
    end

    def pay_order(order)
      order.state = "paid"
      @paid_orders[order.id] = order
      @total += order.total
    end

    def show_paid_orders_details
      puts "Las ordenes pagadas son:"
      @paid_orders.each do |id, order|
        puts "Orden con ID: #{id} - Total pagado: #{order.total} - Fecha: #{order.date} -"\
          "Nro de items: #{order.items.length}"
        puts "El detalle de la orden es:"
          order.items.each do |code, product|
            puts "  codigo: #{code} - #{product[:name]} -  $#{product[:unit_price]} / und - #{product[:quantity]} Unidades - valor $#{product[:total_item]} "
          end
      end
    end
  end
end



