class WorkOrdersWorker < ApplicationRecord
  belongs_to :work_order
  belongs_to :worker

  validates_presence_of :work_order_id, :worker_id
  validate :limit_5_workers_per_work_order

  private
  def limit_5_workers_per_work_order
    if WorkOrdersWorker.where(:work_order => self.work_order_id).count >= 5
      errors.add(:worker_id, "Cannot add more than 5 workers per work order")
    end
  end
end
