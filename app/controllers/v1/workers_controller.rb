class V1::WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :update, :destroy]

  # GET /workers
  def index
    @workers = Worker.all
    json_response(@workers)
  end

  # POST /workers
  def create
    @worker = Worker.create!(worker_params)
    json_response(@worker, :created)
  end

  # GET /workers/:id
  def show
    json_response(@worker)
  end

  # PUT /workers/:id
  def update
    @worker.update(worker_params)
    head :no_content
  end

  # DELETE /workers/:id
  def destroy
    @worker.destroy
    head :no_content
  end

  private

  def worker_params
    # whitelist params
    params.permit(:name, :company_name, :email)
  end

  def set_worker
    @worker = Worker.find(params[:id])
  end
end
