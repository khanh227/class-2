require 'csv'

module Products
  class CsvGenerate
    def initialize(products)
      @products = products
    end

    def perform
      CSV.generate do |csv|
        csv << header
        @products.each do |product|
          csv << csv_row(product)
        end
      end
    end

    private

    def header
      header = ['Name', 'Description', 'Price', 'Enabled', 'Quatity']
      header
    end

    def csv_row(product)
      csv_row = []
      csv_row << product.name
      csv_row << product.description
      csv_row << product.price
      csv_row << product.enabled
      csv_row << product.quatity
      csv_row
    end
  end
end
