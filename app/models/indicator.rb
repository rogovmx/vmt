class Indicator < ApplicationRecord
  has_many :indicator_values, dependent: :destroy

  validates :name, presence: true

end
