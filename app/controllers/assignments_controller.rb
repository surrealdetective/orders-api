class AssignmentsController < ApplicationController
  def create
    @work_orders_worker = WorkOrdersWorker.create!(work_orders_workers_params)
    json_response(@work_orders_worker, :created)
  end

  private

  def work_orders_workers_params
    # whitelist params
    params.permit(:work_order_id, :worker_id)
  end
end
