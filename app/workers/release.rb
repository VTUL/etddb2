class Release
  @queue = :release
  
  def self.perform(class_type, class_id)
    klass = class_type.constantize.find(class_id)

    klass.availability = klass.availability.release_availability
    klass.save
  end
end
