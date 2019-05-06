module Products
  class ProductGenerateCsv < ExportCsv
    def initialize(objects)
      @objects = objects
    end

    def perform
      ExportCsv.new(objects, Product.column_names).perform
    end
  end
end
