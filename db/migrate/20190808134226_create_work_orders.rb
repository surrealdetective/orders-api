class CreateWorkOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :work_orders do |t|
      t.string :title
      t.string :description
      t.datetime :deadline

      t.timestamps
    end
  end
end
