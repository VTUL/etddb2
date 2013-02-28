#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Content < ActiveRecord::Base
  belongs_to :etd, inverse_of: :contents
  has_many :people_roles, through: :etd

  belongs_to :availability, inverse_of: :contents
  belongs_to :reason, inverse_of: :contents

  has_many :provenances, as: :model
  has_many :conversations, as: :model

  validates_presence_of :availability_id, :etd_id, :reason_id
  validates :bound, inclusion: {in: [true, false], message: "must be boolean"}

  # These allow paperclip to generate the content's path and url dynamically.
  Paperclip.interpolates :file_availability do |attachment, style|
    attachment.instance.availability.name.downcase()
  end
  Paperclip.interpolates :urn do |attachment, style|
    attachment.instance.etd.urn
  end
  Paperclip.interpolates :availability do |attachment, style|
    if attachment.instance.etd.status == "Approved"
      if attachment.instance.etd.availability.access_restriction == "Withheld"
        return "withheld"
      else
        return "available"
      end
    else
      return "submitted"
    end
  end

  # Paperclip mountings/validations
  has_attached_file :content, storage: :filesystem, path: ":rails_root/files/:urn/:filename", url: "/contents/:id"
  validates_attachment_presence :content
  validates_attachment_size :content, less_than: 512.megabytes

  # Carrierwave mountings
  #mount_uploader :content, ContentUploader
  #validates_integrity_of :content
  #validates_processing_of :content
end

class Audio < Content
  validates_presence_of :duration
  validates_numericality_of :duration
end

class Document < Content
  validates_presence_of :page_count
  validates_numericality_of :page_count
end

class Picture < Content
  validates_presence_of :dimensions
end

class Video < Content
  validates_presence_of :duration, :dimensions
  validates_numericality_of :duration
end
