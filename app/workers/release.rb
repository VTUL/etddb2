class Release
    @queue = :release

  def self.perform(class_type, class_id)
    klass = class_type.constantize.find(class_id)
    klass.availability = klass.availability.release_availability
    klass.status = 'Released' if klass.class.name == 'Etd'
    klass.save

    Provenance.create(person: Person.where(group: 'Administration').first, action: 'automatically released', model: klass)

    EtddbMailer.release_authors(klass).deliver
  end
end
