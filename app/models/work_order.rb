class WorkOrder < ApplicationRecord
  has_many :work_orders_workers
  has_many :workers, :through => :work_orders_workers

  validates_presence_of :title, :description, :deadline
end
