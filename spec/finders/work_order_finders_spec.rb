require 'rails_helper'

RSpec.describe WorkOrderFinder, type: :finder do

  describe '#all' do
    let!(:work_orders) { create_list(:work_order, 10) }

    it 'finds all work orders' do
      expect(work_orders.count).to eq 10
    end
  end

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

  describe '#with_worker_id_or_by_deadline' do
    let!(:workers) { create_list(:worker_with_work_orders, 3) }
    let(:worker_id) { workers.first.id }

    it 'switches to #with_worker_id if worker_id is passed' do
      work_order_finder_klass = spy('work_order_finder')

      WorkOrderFinder.with_worker_id_or_by_deadline(worker_id, nil, work_order_finder_klass)
      expect(work_order_finder_klass).to have_recieved(:with_worker_id)
    end

    it 'switches to #by_deadline if deadline passed without worker_id' do
      work_order_finder_klass = spy('work_order_finder')
      deadline = 'true'

      WorkOrderFinder.with_worker_id_or_by_deadline(nil, deadline, work_order_finder_klass)
      expect(work_order_finder_klass).to have_recieved(:by_deadline)
    end

    it 'switches to #all if nothing is passed' do
      work_order_finder_klass = spy('work_order_finder')

      WorkOrderFinder.with_worker_id_or_by_deadline(nil, nil, work_order_finder_klass)
      expect(work_order_finder_klass).to have_recieved(:all)
    end

    it 'switches to #all if deadline is passed as false' do
      work_order_finder_klass = spy('work_order_finder')
      deadline = 'false'

      WorkOrderFinder.with_worker_id_or_by_deadline(nil, deadline, work_order_finder_klass)
      expect(work_order_finder_klass).to have_recieved(:all)
    end

  end
end
