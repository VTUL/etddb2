class Reason < ActiveRecord::Base
  has_many :etds, inverse_of: :reason
  has_many :contents, inverse_of: :reason
  has_many :provenances, as: :model
  has_many :conversations, as: :model

  validates_presence_of :name, :months_to_release, :months_to_warning, :warn_before_approval
  validates :months_to_release, :months_to_warning, numericality: { only_integer: true }
  validates :warn_before_approval, inclusion: {in: [true, false], message: "must be boolean"}
end
