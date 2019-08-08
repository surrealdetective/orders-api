class WorkOrderFinder
  def self.with_worker_id(worker_id, order_by='deadline', sequence='asc')
    WorkOrder.
      joins(:work_orders_workers).
      where(work_orders_workers: {
        worker_id: worker_id
      }).order(order_by.to_sym => sequence.to_sym)
  end

  def self.by_deadline(sequence='asc')
    WorkOrder.order(deadline: sequence.to_sym)
  end
end
