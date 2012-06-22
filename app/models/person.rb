#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################
require 'edauth'

class Person < ActiveRecord::Base
  self.table_name = "people"

  # Assicate tables
  has_many :people_roles, dependent: :destroy
  has_many :roles, through: :people_roles
  has_many :etds, through: :people_roles

  # Validates attributes
  validates_presence_of :first_name, :last_name, :pid, :email
  validates_uniqueness_of :pid, :email

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [ :pid ]

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
end
