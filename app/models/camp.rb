class Camp < ApplicationRecord

  has_many :camplocations
  has_many :locations, through: :camplocations

  include PgSearch::Model

  pg_search_scope :search, against: [:name, :type]

  enum status: [:active, :inactive]

  after_initialize :set_default_status, :if => :new_record?

  def set_default_status
    self.status ||= :inactive
  end

  def self.to_csv
    attributes = %w[name]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |camp|
        csv << attributes.map{ |attr| camp[attr] }
      end
    end
  end

end
