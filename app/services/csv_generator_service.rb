class CsvGeneratorService
  attr_accessor :klass

  def initialize(klass)
    @klass = klass
  end

  def to_csv_export
    CSV.generate(headers: true) do |csv|
      csv << klass.attributes
      klass.all.each do |l|
        csv << klass.attributes.map { |attr| l[attr] }
      end
    end
  end
end
