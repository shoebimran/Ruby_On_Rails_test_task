# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    let!(:user1) { create(:user, gender: 'male') }
    let!(:user2) { create(:user, gender: 'female') }

    it 'assigns @users and renders the index template' do
      get '/users'

      expect(assigns(:users)).to eq([user1, user2])
      expect(response).to render_template('index')
    end
  end
end
