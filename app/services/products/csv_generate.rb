require 'csv'

module Products
  class CsvGenerate
    def initialize(products)
      @products = products
    end

    def perform
      CSV.generate("\uFEFF") do |csv|
        csv << self.send(:headers)
        @products.each do |object|
          csv << headers.map{ |attr| object.public_send(attr) }
        end
      end
    end

    private
      def headers
        Product.column_names
      end
  end
end
