class WorkOrdersWorker < ApplicationRecord
  belongs_to :work_order
  belongs_to :worker

  validates_presence_of :work_order_id, :worker_id
end
