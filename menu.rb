module Menu
  class Menu
    attr_reader :products
    def initialize
      @products = {}
      load_menu
    end

    def show_products
      puts "Los productos disponibles son:"
      @products.each do |code, product|
        next unless product[:available]
        product_to_print = "#{code} -  #{product[:name]} - #{product[:price]} "
        puts product_to_print
      end
    end

    def add_product(code, name, price, available)
      return "El producto ya existe" if @products.keys.include?(code)
      @products[code.to_sym] = { code: code, name: name, price: price, available: true?(available) }
    end

    def find_product(code)
      product = @products[code.to_sym]
      product && product[:available] ? product : nil
    end

    private

    def load_menu
      file = IO.readlines("products.txt")
      file.each do |product|
        code, name, price, available = product.chomp.split("-")
        @products[code.to_sym] = { code: code, name: name, price: price.to_f, available: true?(available) }
      end
    end

    def true?(obj)
      obj.to_s == "true"
    end
  end
end

