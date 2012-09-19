#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Content < ActiveRecord::Base
  belongs_to :etd
  belongs_to :availability
  
  has_many :provenances, as: :model
  #has_many :messages, as: :model

  validates_presence_of :availability_id, :etd_id
  validates :bound, inclusion: {in: [true, false], message: "must be boolean"}

  # These allow paperclip to generate the content's path and url dynamically.
  Paperclip.interpolates :availability do |attachment, style|
    attachment.instance.availability.name.downcase()
  end
  Paperclip.interpolates :etd_urn do |attachment, style|
    attachment.instance.etd.urn
  end
  Paperclip.interpolates :etd_status do |attachment, style|
    if attachment.instance.etd.status == "Approved"
      if attachment.instance.etd.availability.name == "Withheld"
        return "withheld"
      else
        return "available"
      end
    else
      return "submitted"
    end
  end

  # Paperclip mountings/validations
  has_attached_file :content, storage: :filesystem, path: ":rails_root/files/:etd_urn/:filename", url: "/:etd_status/:etd_urn/:availability/:filename"
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
