class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable


  attr_accessor :terms_of_service

  PASSWORD_FORMAT = /\A
  (?=.{7,})
  (?=.*[a-z])
  (?=.*[A-Z])
  (?=.*[[:^alnum:]])
  /x

  validates :password, format: PASSWORD_FORMAT
  validates :first_name, :phone, :country, presence: true
  validates :phone, numericality: { :greater_than_or_equal_to => 0, only_integer: true }
  validates :terms_of_service, acceptance: {message: "You have to agree to the terms of service. Contact Admin at xyz@projectname.com "}

end
