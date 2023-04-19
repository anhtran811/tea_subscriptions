require 'rails_helper'

describe 'GET /customers/:id/subscriptions' do
  context 'if the customer exists' do
    it 'returns all of their subscriptions' do
      customer = create(:customer)
      tea1 = create(:tea)
      tea2 = create(:tea)
      tea3 = create(:tea)

      subscription = create(:subscription, customer_id: customer.id, tea_id: tea1.id)
      subscription = create(:subscription, customer_id: customer.id, tea_id: tea2.id)
      subscription = create(:subscription, customer_id: customer.id, tea_id: tea3.id)

      get "/api/v1/customers/#{customer.id}/subscriptions" 

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(subscription_response).to have_key(:data)
      expect(subscription_response[:data]).to be_an(Array)

      expect(subscription_response[:data][0]).to be_a(Hash)

      data = subscription_response[:data][0]

      expect(data).to have_key(:id)
      expect(data[:id]).to be_a(String)

      expect(data).to have_key(:type)
      expect(data[:type]).to be_a(String)

      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      expect(data[:attributes]).to have_key(:name)
      expect(data[:attributes][:name]).to be_a(String)

      expect(data[:attributes]).to have_key(:price)
      expect(data[:attributes][:price]).to be_a(Float)

      expect(data[:attributes]).to have_key(:status)
      expect(data[:attributes][:status]).to be_a(String)

      expect(data[:attributes]).to have_key(:frequency)
      expect(data[:attributes][:frequency]).to be_a(String)

      expect(data[:attributes]).to have_key(:customer_id)
      expect(data[:attributes][:customer_id]).to be_an(Integer)

      expect(data[:attributes]).to have_key(:tea_id)
      expect(data[:attributes][:tea_id]).to be_an(Integer)
    end
  end

  context 'if the customer does not exist' do
    it 'returns an error message' do
      customer = create(:customer)
      tea1 = create(:tea)
      tea2 = create(:tea)
      tea3 = create(:tea)

      subscription = create(:subscription, customer_id: customer.id, tea_id: tea1.id)
      subscription = create(:subscription, customer_id: customer.id, tea_id: tea2.id)
      subscription = create(:subscription, customer_id: customer.id, tea_id: tea3.id)

      get "/api/v1/customers/#{Customer.last.id+1}/subscriptions" 

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(subscription_response).to have_key(:error)
      expect(subscription_response[:error]).to be_an(Array)

      expect(subscription_response[:error][0]).to have_key(:title)
      expect(subscription_response[:error][0][:title]).to be_a(String)
      expect(subscription_response[:error][0][:title]).to match(/Couldn't find Customer with 'id'=#{Customer.last.id+1}/)

      expect(subscription_response[:error][0]).to have_key(:status)
      expect(subscription_response[:error][0][:status]).to be_a(String)
    end
  end
end