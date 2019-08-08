require 'rails_helper'

RSpec.describe 'Workers API', type: :request do
  # initialize test data
  let!(:workers) { create_list(:worker, 10) }
  let(:worker_id) { workers.first.id }

  # Test suite for GET /workers
  describe 'GET /workers' do
    # make HTTP get request before each example
    before { get '/workers' }

    it 'returns workers' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /workers/:id
  describe 'GET /workers/:id' do
    before { get "/workers/#{worker_id}" }

    context 'when the record exists' do
      it 'returns the worker' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(worker_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:worker_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Worker/)
      end
    end
  end

  # Test suite for POST /workers
  describe 'POST /workers' do
    # valid payload
    let(:valid_attributes) { { name: 'Alex', company_name: 'Hatchway', email: 'alex@cool.com' } }

    context 'when the request is valid' do
      before { post '/workers', params: valid_attributes }

      it 'creates a worker' do
        expect(json['name']).to eq('Alex')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/workers', params: { name: 'Foo', company_name: 'Bar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Email can't be blank/)
      end
    end
  end

  # Test suite for PUT /workers/:id
  describe 'PUT /workers/:id' do
    let(:valid_attributes) { { name: 'Allison' } }

    context 'when the record exists' do
      before { put "/workers/#{worker_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /workers/:id
  describe 'DELETE /workers/:id' do
    before { delete "/workers/#{worker_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
