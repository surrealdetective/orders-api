require 'rails_helper'

RSpec.describe WorkOrdersWorker, type: :model do
  it { should belong_to(:worker) }
  it { should belong_to(:work_order) }

  it { should validate_presence_of(:work_order_id) }
  it { should validate_presence_of(:worker_id) }
end
