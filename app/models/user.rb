class User < ApplicationRecord
  include PgSearch::Model

  attr_accessor :terms_of_service

  has_one_attached :image, dependent: :destroy

  has_many :applications
  has_many :camps, through: :applications

  pg_search_scope :search, against: [:id, :first_name, :email], using: { tsearch: { prefix: true, dictionary: "english" } }

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, validate_on_invite: true

  enum role: [:user, :admin]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.attributes
    %w[email first_name country phone]
  end

  def validate_password
    rules = {
      'must contain at least one lowercase letter'  => /[a-z]+/,
      'must contain at least one uppercase letter'  => /[A-Z]+/,
      'must contain at least one digit'             => /\d+/,
      'must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match(regex)
    end
  end

  validate :validate_password, unless: lambda { |u| u.password.nil? }
  validates :first_name, :phone, :country, presence: true
  validates :phone, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :terms_of_service, acceptance: { message: 'You have to agree to the terms of service. Contact Admin at xyz@projectname.com' }
end
