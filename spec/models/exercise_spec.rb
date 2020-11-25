require 'rails_helper'

RSpec.describe Exercise, type: :model do
  let!(:exercise) { create :exercise }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_numericality_of(:duration).is_greater_than(0).only_integer }
end
