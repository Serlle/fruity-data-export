class CsvService
  def initialize(fruits)
    @fruits = fruits
  end

  def generate_format_csv(fruits)
    CSV.generate(headers: true)  do |csv|
      csv << ["Name", "Family", "Genus", "Order"]

      fruits[:body].each do |fruit|
        csv << [fruit["name"], fruit["family"], fruit["genus"], fruit["order"]]
      end
    end 
  end
end