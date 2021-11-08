class Location < ApplicationRecord

  has_many :camplocations
  has_many :camps, through: :camplocations

  include PgSearch::Model

  pg_search_scope :search, against: [:name]

  def self.to_csv
    attributes = %w[name]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |location|
        csv << attributes.map{ |attr| location[attr] }
      end
    end
  end
end
