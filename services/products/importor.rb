module Products
  class Importor < ImportCsv
    def perform
      CSV.foreach(@file.path, headers: true) do |row|
        product = product(row)
        product.save ? @success += 1 : @failure += 1
      end
      success
    end

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
