require 'rails_helper'

RSpec.describe IndicatorValue, type: :model do
  it { should belong_to :match }
  it { should belong_to :player }
  it { should belong_to :indicator }
end
