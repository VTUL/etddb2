#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Content < ActiveRecord::Base
  belongs_to :etd
  validates_presence_of :filename, :size, :availability, :types, :bound
  validates_numericality_of :size 
 # validates_format_of :filename,
 #                     :with => %r{([A-Z]([A-Z]|[a-z])*)(_([a-z]|[A-Z])+)*(_[D|T])(_([0-9]{4}))\.(([a-z]|[A-Z]){3})},
 #                     :message => 'must have these component <Last name>_<first (and) middle initials>_T or D_<yyyy of defense' 

  validates_format_of :types,
                      :with => /^image/,
                      :message => "--- you can only upload pictures"

  def uploaded_picture=(content_field)
    self.filename = base_part_of(content_field.original_filename)
    self.types = content_field.content_type.chomp
    #self.data = picture_field.read
    self.availability = 'unrestricted'
    self.size = 10000
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
