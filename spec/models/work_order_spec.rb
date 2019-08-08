require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  it {should have_many(:workers)}

  it {should validate_presence_of(:title) }
  it {should validate_presence_of(:description) }
  it {should validate_presence_of(:deadline) }
end
