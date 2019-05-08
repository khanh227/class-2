class ImportCsv
  def initialize(file_import:)
    @file = file_import
    @success = 0
    @failure = 0
    @messages = ''
  end

  def success
    @success == 0 ? false : true
  end

  def messages
    @messages = "Success: #{@success}, Failure: #{@failure}"
  end

  def csv_valid?
    @messages = is_csv_file? ? 'message true' : 'message fail'
    is_csv_file?
  end

  private
    def is_csv_file?
<<<<<<< HEAD
      File.extname(@file.original_filename) == '.csv'
=======
      File.extname(@file) == '.csv'
>>>>>>> 2932f7f35437042ed4cd9671187d737da92542ec
    end
end 
