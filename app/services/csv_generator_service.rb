class CsvGeneratorService
  def initialize(klass)
    @class= klass
  end

  def to_csv_export
    CSV.generate(headers: true) do |csv|
      csv << @class.attributes
      @class.all.each do |l|
        csv << @class.attributes.map{ |attr| l[attr] }
      end
    end
  end
end
