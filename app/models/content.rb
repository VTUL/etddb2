#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Content < ActiveRecord::Base
  belongs_to :etd
  belongs_to :availability
  
  # Paperclip mountings/validations
  has_attached_file :content, storage: :filesystem, path: ":rails_root/public/bin/submitted/:filename"
  validates_attachment_presence :content
  validates_attachment_size :content, less_than: 512.megabytes
  
  # Carrierwave mountings
  #mount_uploader :content, ContentUploader
  #validates_integrity_of :content
  #validates_processing_of :content

  validates_presence_of :availability_id, :etd_id
  validates :bound, inclusion: {in: [true, false], message: "must be boolean"}
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
