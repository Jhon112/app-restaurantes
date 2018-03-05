module Order
  class Order
    attr_accessor :state
    attr_reader :id, :items, :total, :date

    def initialize(id)
      @id = id
      @items = {}
      @total = 0
      @state = "ordering"
      @date = Time.now
    end

    def add_item(product, quantity)
      total_item = product[:price] * quantity
      @total += total_item
      @items[product[:code].to_sym] = { name: product[:name], unit_price: product[:price],
                                        quantity: quantity, total_item: total_item }
    end

    def show_total
      puts "El total de la orden es $ #{@total}"
    end
  end

  class OrderQueue
    attr_reader :orders

    def initialize
      @total = 0
      @orders = {}
    end

    def add_order(order)
      order.state = "in_queue"
      @total += order.total
      @orders[order.id] = order
    end

    def show_orders
      puts "Las ordenes en cola son:"
      @orders.each do |id, order|
        puts "ID: #{id} - Total pagado: #{order.total} - Fecha: #{order.date} -"\
        "Nro de items: #{order.items.length}"
      end
    end
  end
end

