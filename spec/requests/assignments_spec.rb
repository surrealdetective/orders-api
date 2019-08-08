require 'rails_helper'

RSpec.describe 'Assignments API', type: :request do
  # initialize test data
  let!(:worker_id) { create(:worker).id }
  let(:work_order_id) { create(:work_order).id }

  # Test suite for POST /assignments
  describe 'POST /assignments' do
    # valid payload
    let(:valid_attributes) { { work_order_id: work_order_id, worker_id: worker_id } }

    context 'when the request is valid' do
      before { post '/assignments', params: valid_attributes }

      it 'creates a worker' do
        expect(json['work_order_id']).to eq(work_order_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/assignments', params: { work_order_id: 100, worker_id: 100 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Work order must exist, Worker must exist/)
      end
    end
  end
end
