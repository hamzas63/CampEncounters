require 'csv'

class Location < ApplicationRecord
  has_many :camp_locations, dependent: :destroy
  has_many :camps, through: :camp_locations

  include PgSearch::Model

  pg_search_scope :search, against: [:name], using: {tsearch: {prefix: true, dictionary: "english"}}

  private

  def self.attributes
    %w[name]
  end
end
