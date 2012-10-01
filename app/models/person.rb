#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################
#require 'edauth'

class LegacyPerson < ActiveRecord::Base
  self.table_name = "people"

  has_many :people_roles, dependent: :destroy, foreign_key: 'person_id', inverse_of: :person
  has_many :roles, through: :people_roles
  has_many :etds, through: :people_roles
  has_many :created_provenances, class_name: 'Provenance', inverse_of: :person
  has_many :provenances, as: :model
  has_many :attached_conversations, as: :model, class_name: 'Conversation'

  validates_presence_of :first_name, :last_name

  def name
    if self.display_name.to_s.empty?
      return "#{self.first_name} #{self.last_name}"
    end
    return self.display_name
  end
end

class Person < LegacyPerson
  self.table_name = "people"

  has_many :receipts, foreign_key: 'participant_id', inverse_of: :participant
  has_many :conversations, through: :receipts
  has_many :recieved_messages, through: :conversations, source: :messages
  has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message', inverse_of: :sender

  validates_presence_of :pid, :email
  validates_uniqueness_of :pid, :email
  validates :show_email, inclusion: {in: [true, false], message: "must be boolean"}

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:pid]

  def unread_count
    count = 0
    self.conversations.each do |c|
      if !c.archived_by?(self) && !c.read_by?(self)
        count += 1
      end
    end
    return count
  end
end
