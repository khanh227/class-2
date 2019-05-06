require 'csv'

module Products
  class CsvGenerate
    def initialize(products)
      @products = products
    end

    def perform
      header = ['Name', 'Description', 'Price', 'Enabled', 'Quatity']
      CSV.generate("\uFEFF") do |csv|
        csv << header
        @products.each do |product|
          csv << product
        end
      end
    end
  end
end
