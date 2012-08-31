class Conversation < ActiveRecord::Base
  belongs_to :model, polymorphic: true

  has_many :messages, inverse_of: :conversation
  accepts_nested_attributes_for :messages
  has_many :senders, through: :messages
  has_many :receipts, inverse_of: :conversation
  has_many :participants, through: :receipts
  has_many :provenances, as: :model

  validates_presence_of :subject, :participants

  def archived_by?(person)
    return self.receipts.where(participant_id: person.id).first.archived.equal?(true)
  end
  def set_archived(person, toggle = true)
    receipt = self.receipts.where(participant_id: person.id).first
    receipt.archived = toggle
    receipt.save
  end

  def read_by?(person)
    return self.receipts.where(participant_id: person.id).first.read.equal?(true)
  end
  def set_read(person, toggle = true)
    receipt = self.receipts.where(participant_id: person.id).first
    receipt.read = toggle
    receipt.save
  end
end
