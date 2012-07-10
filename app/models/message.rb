class Message < ActiveRecord::Base
    belongs_to :sender, class_name: "Person"
    belongs_to :recipient, class_name: "Person"
    belongs_to :model, polymorphic: true

    validates_presence_of :msg, :sender, :recipient
end
