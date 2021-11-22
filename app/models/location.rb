require 'csv'
class Location < ApplicationRecord
  has_many :camp_locations, dependent: :destroy
  has_many :camps, through: :camp_locations

  include PgSearch::Model

  pg_search_scope :search, against: [:name]

  private

  def self.to_csv
    attributes = %w[name]
    csv= CsvGenerator.to_csv_export(attributes, self)
  end
end
