class Worker < ApplicationRecord
  validates_presence_of :name, :company_name, :email
  has_many :work_orders_workers
  has_many :work_orders, :through => :work_orders_workers
end
