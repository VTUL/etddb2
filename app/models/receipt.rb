class Receipt < ActiveRecord::Base
  belongs_to :participant, class_name: 'Person', inverse_of: :receipts
  belongs_to :conversation, inverse_of: :receipts

  validates :read, inclusion: {in: [true, false], message: "must be boolean"}
  validates :archived, inclusion: {in: [true, false], message: "must be boolean"}
end
