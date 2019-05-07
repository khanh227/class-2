require 'csv'

module Products
  class Importor < ImportCsv
    def perform
      if csv_valid?
        CSV.foreach(@file.path, headers: true) do |row|
          product(row).save ? @success += 1 : @failure += 1
        end
        success
      else
        false
      end
    end

    private
      def product(row)
        product = Product.new
        product.name = row['name']
        product.description = row['description']
        product.price = row['price']
        product.quatity = row['quatity']
        product
      end
  end
end
