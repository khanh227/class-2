require 'csv'

class ExportCsv
  def initialize(objects, attributes)
    @objects = objects
    @attributes = attributes
  end

  def perform
    bom = "\uFEFF"
    CSV.generate(bom) do |csv|
      csv << attributes
      objects.each do |object|
        csv << attributes.map{ |attr| object.public_send(attr) }
      end
    end
  end

  private
  attr_reader :attributes, :objects
end
