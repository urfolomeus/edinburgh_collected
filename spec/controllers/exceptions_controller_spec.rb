require 'rails_helper'

describe ExceptionsController do
  describe 'GET bad_request' do
    before { get :bad_request }

    it 'displays the bad_request page' do
      expect(response).to render_template('exceptions/bad_request')
    end

    it 'has a 400 status' do
      expect(response.status).to eql(400)
    end
  end

  describe 'GET not_authorized' do
    before { get :not_authorized }

    it 'displays the not_authorized page' do
      expect(response).to render_template('exceptions/not_authorized')
    end

    it 'has a 401 status' do
      expect(response.status).to eql(401)
    end
  end

  describe 'GET not_found' do
    before { get :not_found }

    it 'displays the not_found page' do
      expect(response).to render_template('exceptions/not_found')
    end

    it 'has a 404 status' do
      expect(response.status).to eql(404)
    end
  end

  describe 'GET unprocessable_entity' do
    before { get :unprocessable_entity }

    it 'displays the unprocessable_entity page' do
      expect(response).to render_template('exceptions/unprocessable_entity')
    end

    it 'has a 422 status' do
      expect(response.status).to eql(422)
    end
  end

  describe 'GET internal_server_error' do
    before { get :internal_server_error }

    it 'displays the internal_server_error page' do
      expect(response).to render_template('exceptions/internal_server_error')
    end

    it 'has a 500 status' do
      expect(response.status).to eql(500)
    end
  end
end
