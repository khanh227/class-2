require 'csv'

class ExportCsv
  def initialize(objects, attributes)
    @objects = objects
    @attributes = attributes
  end

  def perform
    CSV.generate("\uFEFF") do |csv|
      csv << @attributes
      @objects.each do |object|
        csv << @attributes.map{ |attr| object.public_send(attr) }
      end
    end
  end
end
