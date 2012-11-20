class Warning
  @queue = :warning

  def self.perform(class_type, class_id)
    klass = class_type.constantize.find(class_id)

    EtddbMailer.warn_authors(klass).deliver

    Provenance.create(person: Person.where(group: 'Administration').first, action: 'automatically warned the authors of', model: klass)
  end
end
