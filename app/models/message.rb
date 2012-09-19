class Message < ActiveRecord::Base
  belongs_to :conversation, inverse_of: :messages
  belongs_to :sender, class_name: 'Person', inverse_of: :sent_messages

  has_many :receipts, through: :conversation
  has_many :participants, through: :receipts
  has_many :provenances, as: :model

  validates_presence_of :msg, :sender, :conversation
end
