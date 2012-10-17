class Archive
  @queue = :archive

  def self.perform(etd_id)
    etd = Etd.find(etd_id)
    # Back up to the filesystem.
  end
end
