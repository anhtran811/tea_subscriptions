require 'rails_helper'

describe 'POST /customers/:customer_id/teas/:tea_id/' do
  context 'if the customer tea subscription is successfully created' do
    it 'creates a tea subscription for a customer' do
      customer = create(:customer)
      tea = create(:tea)

      subscription_params = { name: "Detox tea",
                              price: 10.99,
                              status: "active",
                              frequency: "biweekly",
                              customer_id: customer.id,
                              tea_id: tea.id
                            }
      headers = { "CONTENT_TYPE": "application/json"}

      expect(Subscription.count).to eq(0)
      expect(customer.subscriptions.count).to eq(0)

      post "/api/v1/customers/#{customer.id}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
      tea_subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(Subscription.count).to eq(1)
      expect(customer.subscriptions.count).to eq(1)

      expect(tea_subscription_response).to have_key(:data)

      expect(tea_subscription_response[:data]).to have_key(:id)
      expect(tea_subscription_response[:data][:id]).to be_a(String)

      expect(tea_subscription_response[:data]).to have_key(:type)
      expect(tea_subscription_response[:data][:type]).to be_a(String)

      expect(tea_subscription_response[:data]).to have_key(:attributes)
      expect(tea_subscription_response[:data][:attributes]).to be_a(Hash)

      response_data = tea_subscription_response[:data][:attributes]

      expect(response_data).to have_key(:name)
      expect(response_data[:name]).to be_a(String)

      expect(response_data).to have_key(:price)
      expect(response_data[:price]).to be_a(Float)

      expect(response_data).to have_key(:status)
      expect(response_data[:status]).to be_a(String)

      expect(response_data).to have_key(:frequency)
      expect(response_data[:frequency]).to be_a(String)

      expect(response_data).to have_key(:customer_id)
      expect(response_data[:customer_id]).to be_an(Integer)

      expect(response_data).to have_key(:tea_id)
      expect(response_data[:tea_id]).to be_an(Integer)
    end
  end
end