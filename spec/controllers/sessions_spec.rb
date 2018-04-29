# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  it 'renders the login page' do
    get :new
    expect(response).to render_template(:new)
  end
end
