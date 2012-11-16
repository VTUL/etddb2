class Warning
  @queue = :warning

  def self.perform(class_type, class_id)
    klass = class_type.constantize.find(class_id)

    # TODO: Warn.
  end
end
