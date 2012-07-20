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
  has_many :provenances, as: :model
  #has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  #has_many :recieved_messages, class_name: 'Message', foreign_key: 'recipient_id'
  #has_many :messages, as: :model

  validates_presence_of :first_name, :last_name, :pid, :email
  validates_uniqueness_of :pid, :email
  validates :show_email, inclusion: {in: [true, false, nil], message: "must be boolean"}

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:pid]

  def name
    if self.display_name.to_s.empty?
      return "#{self.first_name} #{self.last_name}"
    end
    return self.display_name
  end
end
