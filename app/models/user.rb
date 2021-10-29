class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include PgSearch::Model

  pg_search_scope :search, against: [:id, :first_name, :email]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  attr_accessor :terms_of_service

  def set_default_role
    self.role ||= :user
  end

  def validate_password
    rules = {
      'must contain at least one lowercase letter'  => /[a-z]+/,
      'must contain at least one uppercase letter'  => /[A-Z]+/,
      'must contain at least one digit'             => /\d+/,
      'must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match( regex )
    end
  end

  validate :validate_password
  validates :first_name, :phone, :country, presence: true
  validates :phone, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :terms_of_service, acceptance: { message: 'You have to agree to the terms of service. Contact Admin at xyz@projectname.com' }
end
