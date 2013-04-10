#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################
class RetiredValidator < ActiveModel::Validator
  def validate(record)
    if record.retired and record.retired_at.nil?
      record.errors[:base] << "Cannot be retired without a retirement date."
    end
  end
end

class CopyrightStatement < ActiveRecord::Base
  has_many :etds, inverse_of: :copyright_statement
  has_many :provenances, as: :model
  has_many :conversations, as: :model

  validates_presence_of :statement
  validates :retired, inclusion: {in: [true, false], message: "must be boolean"}
  validates_with RetiredValidator
end
