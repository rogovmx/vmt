class IndicatorValue < ApplicationRecord
  belongs_to :match
  belongs_to :indicator
  belongs_to :player

  scope :completed, -> { where(val: true) }
end
