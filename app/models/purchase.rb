class Purchase < ApplicationRecord
  has_one :slot

  #scope :without_referer, -> { where(referrer: nil) }
end
