require 'rails_helper'

RSpec.describe WorkOrdersWorker, type: :model do
  it { should belong_to(:worker) }
  it { should belong_to(:work_order) }

  it { should validate_presence_of(:work_order_id) }
  it { should validate_presence_of(:worker_id) }

  it 'can have 5 workers assigned to a single work order' do
    expect(create(:work_order_with_workers, work_orders_workers_count: 5)).to be_truthy
  end

  it 'cannot have 6 workers assigned to a single work order' do
    expect {create(:work_order_with_workers, work_orders_workers_count: 6)}.to raise_error ActiveRecord::RecordInvalid
  end
end
