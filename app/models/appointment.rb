class Appointment < ApplicationRecord
  belongs_to :slot
  belongs_to :client
end
