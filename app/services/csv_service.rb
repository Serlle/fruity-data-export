class CsvService
  def initialize(fruits)
    @fruits = fruits
  end

  def generate_format_csv
    CSV.generate(headers: true)  do |csv|
      csv << ["Name", "Family", "Genus", "Order", "Calories", "Fat", "Sugar", "Carbohydrates", "Protein"]
      @fruits[:body].each do |fruit|
        csv << [fruit["name"], fruit["family"], fruit["genus"], fruit["order"], fruit["nutritions"]["calories"], fruit["nutritions"]["fat"], fruit["nutritions"]["sugar"], fruit["nutritions"]["carbohydrates"], fruit["nutritions"]["protein"]]
      end
    end 
  end
end