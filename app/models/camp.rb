class Camp < ApplicationRecord
  has_many :camp_locations, dependent: :destroy
  has_many :applications
  has_many :locations, through: :camp_locations
  has_many :users, through: :applications

  include PgSearch::Model

  pg_search_scope :search, against: [:name, :camp_type, :status], using: {tsearch: {prefix: true, dictionary: "english"}}

  enum status: [:active, :inactive]

  validate :end_date_after_start_date?, :end_date_after_registration_date?
  validates :name, :end_date, :start_date, presence: true

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= :inactive
  end

  def toggle_status
    if self.inactive?
      self.active!
    elsif self.active?
      self.inactive!
    end
  end

  def self.attributes
    %w[name]
  end

  def location_names
    locations.pluck(:name).reject(&:blank?).join('  ')
  end

  def end_date_after_start_date?
    if !end_date.nil? && !start_date.nil?
      if end_date < start_date
        errors.add :end_date, "must be after start date"
      end
    end
  end

  def end_date_after_registration_date?
    if !end_date.nil? && !registartion_date.nil?
      if end_date < registartion_date
        errors.add :registartion_date, "must be before end date"
      end
    end
  end
end
