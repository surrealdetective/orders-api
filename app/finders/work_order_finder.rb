class WorkOrderFinder
  def self.all
    WorkOrder.all
  end

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

  def self.with_worker_id_or_by_deadline(worker_id=nil, deadline=nil, work_order_klass=WorkOrderFinder)
    deadline = deadline == 'true' ? true : deadline
    deadline = deadline == 'false' ? false : deadline

    if !worker_id.nil?
      order_by = case deadline
        when nil; 'deadline'
        when true; 'deadline'
        when false; 'id'
      end
      work_order_klass.with_worker_id(worker_id.to_i, order_by.to_s)
    elsif deadline
      work_order_klass.by_deadline
    else
      work_order_klass.all
    end
  end
end
