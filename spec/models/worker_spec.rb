require 'rails_helper'

RSpec.describe Worker, type: :model do
  it { should have_many(:work_orders) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:company_name) }
  it { should validate_uniqueness_of(:email) }
end
