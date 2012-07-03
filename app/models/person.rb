#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################
#require 'edauth'

class Person < ActiveRecord::Base
  self.table_name = "people"

  has_many :people_roles, dependent: :destroy
  has_many :roles, through: :people_roles
  has_many :etds, through: :people_roles
  has_many :created_provenances, class_name: 'Provenance'
  has_many :subject_of_provenances, class_name: 'Provenance', as: :model

  validates_presence_of :first_name, :last_name, :pid, :email
  validates_uniqueness_of :pid, :email
  validates :show_email, inclusion: {in: [true, false, nil], message: "must be boolean"}

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:pid]
end
