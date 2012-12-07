class Release
  @queue = :release
  
  def self.perform(class_type, class_id)
    klass = nil
    case class_type
    when 'Etd'
      klass = Etd.find(class_id)
    when 'Content'
      klass = Content.find(class_id)
    end

    klass.availability = klass.availability.release_availability
    klass.save
  end
end
