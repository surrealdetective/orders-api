class V1::WorkOrdersController < ApplicationController
  before_action :set_work_order, only: [:show, :update, :destroy]

  # GET /work_orders
  def index
    @work_orders = WorkOrderFinder.
      with_worker_id_or_by_deadline(params[:worker_id], params[:deadline]).
      paginate(page: params[:page], per_page: 20)
    json_response(@work_orders)
  end

  # POST /work_orders
  def create
    @work_order = WorkOrder.create!(work_order_params)
    json_response(@work_order, :created)
  end

  # GET /work_orders/:id
  def show
    json_response(@work_order)
  end

  # PUT /work_orders/:id
  def update
    @work_order.update(work_order_params)
    head :no_content
  end

  # DELETE /work_orders/:id
  def destroy
    @work_order.destroy
    head :no_content
  end

  private

  def work_order_params
    # whitelist params
    params.permit(:title, :description, :deadline)
  end

  def set_work_order
    @work_order = WorkOrder.find(params[:id])
  end

end
