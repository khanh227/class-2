require 'csv'

module Products
  class ProductGenerateCsv
    def initialize(objects)
      @objects = objects
    end

    def header
      Product.column_names
    end

    def perform
      CSV.generate("\uFEFF") do |csv|
        csv << header
        @objects.each do |object|
          csv << header.map{ |attr| object.public_send(attr) }
        end
      end
    end
  end
end
