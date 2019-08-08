class CreateWorkOrdersWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :work_orders_workers do |t|
      t.integer :work_order_id, :null => false
      t.integer :worker_id, :null => false
      t.index [:work_order_id, :worker_id], :unique => true, :name => 'worker_orders_workers_by_keys'

      t.timestamps
    end
  end
end
