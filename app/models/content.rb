#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Content < ActiveRecord::Base
  belongs_to :etd
  # validation
  validates :filename, :size, :availability, :types, :bound, :presence => true
  validates :size, :numericality => {:greater_than_or_equal_to => 0}
  
 # validates_format_of :filename,
 #                     :with => %r{([A-Z]([A-Z]|[a-z])*)(_([a-z]|[A-Z])+)*(_[D|T])(_([0-9]{4}))\.(([a-z]|[A-Z]){3})},
 #                     :message => 'must have these component <Last name>_<first (and) middle initials>_T or D_<yyyy of defense' 

#  validates :types, :format => {
#                      :with => /^image/,
#                      :message => "--- you can only upload pictures"
#  }

  def uploaded_picture=(content_field)
    self.filename = base_part_of(content_field.original_filename)
    self.types = content_field.content_type.chomp
    #self.data = picture_field.read
    self.availability = 'unrestricted'
    self.size = content_field.filesize
    self.bound = 'no'
  end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '' )
  end

  def self.find_contents_for_view(id)
    @etd=Etd.find(:first, :conditions => "id= '#{id}'")
    @contents=@etd.contents
  end 
end

class Document < Content
  validates_presence_of :page_count
  validates_numericality_of :page_count   
end

class Video < Content
end

class Audio < Content
end
