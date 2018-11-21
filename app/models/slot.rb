class Slot < ApplicationRecord
  has_one :appointment
  belongs_to :purchase
  belongs_to :location
  has_many :slot_variations
end