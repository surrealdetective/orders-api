require 'rails_helper'

RSpec.describe WorkOrderFinder, type: :finder do

  describe '#self.with_worker_id' do
    let!(:work_orders) { create_list(:work_order_with_workers, 3) }
    let(:worker_id) { work_orders.first.id }

    it 'finds work orders for a given worker' do
      work_orders = WorkOrderFinder.with_worker_id(worker_id)
      expect(work_orders.all? { |work_order|
        work_order.work_orders_workers.map(&:worker_id).include?(worker_id)
      }).to be true
    end
  end

  describe '#self.by_deadline' do
    let!(:work_orders_with_desc_dates) {
      15.downto(11).map { |n| create(:work_order, deadline: "2030-12-#{n}")}
    }

    it 'finds work orders by deadline in asc order' do
      work_orders = WorkOrderFinder.by_deadline

      expect(work_orders.map {|work_order| work_order.deadline.strftime('%F')}).
        to eq ["2030-12-11", "2030-12-12", "2030-12-13", "2030-12-14", "2030-12-15"]
    end
  end
end
