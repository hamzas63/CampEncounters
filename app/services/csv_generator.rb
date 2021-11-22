class CsvGenerator

  def self.to_csv_export(attributes,model)
    CSV.generate(headers: true) do |csv|
      csv << attributes
      model.all.each do |location|
        csv << attributes.map{ |attr| location[attr] }
      end
    end
  end
end
