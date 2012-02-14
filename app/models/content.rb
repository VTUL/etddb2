#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Content < ActiveRecord::Base
  belongs_to :etd
  belongs_to :availability
  validates_presence_of :uploaded_file_name, :uploaded_file_size, :uploaded_content_type, :availability_id, :bound

  validates :uploaded_file_size, :numericality => {:greater_than_or_equal_to => 0}

  has_attached_file :uploaded,
    :storage => :filesystem,
    :path => "/usr/home/shpar/etddb2devel/public/theses/:filename"

  attr_accessor :pdf_file_name

 # validates_format_of :filename,
 #                     :with => %r{([A-Z]([A-Z]|[a-z])*)(_([a-z]|[A-Z])+)*(_[D|T])(_([0-9]{4}))\.(([a-z]|[A-Z]){3})},
 #                     :message => 'must have these component <Last name>_<first (and) middle initials>_T or D_<yyyy of defense'

  def get_bin_root()
    File.join( Rails.root, 'public', 'bin' )
  end

  def uploaded=(content_field)
    self.uploaded_file_name = base_part_of(content_field.original_filename)
    self.uploaded_content_type = content_field.content_type.chomp
    #self.data = picture_field.read
    self.availability = Etd.find(:first, self.etd_id).availability
    self.uploaded_file_size = content_field.size
    self.bound = 'no'

    # refer to the etd class from here content class
    # get_bin_root() returns File.join( Rails.root, 'public', 'bin' )
    tmp_directory = get_bin_root()+ "/submitted"
    if !File.directory?(tmp_directory)
      Dir.mkdir(tmp_directory)
    end
    save_as = File.join( get_bin_root(), "/submitted", content_field.original_filename )

    File.open( save_as.to_s, 'w' ) do |file|
      file.write(content_field.read.force_encoding("UTF-8"))
    end

    self.save!

    return self

  end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '' )
  end

  def self.find_contents_for_view(id)
    @etd=Etd.find(:first, :conditions => "id= '#{id}'")
    @contents=@etd.contents
  end
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
