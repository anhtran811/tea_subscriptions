require 'rails_helper'

describe 'POST /customers/:customer_id/teas/:tea_id/' do
  context 'if the customer tea subscription is successfully created' do
    it 'creates a tea subscription for a customer' do
      customer = create(:customer)
      tea = create(:tea)

      subscription_params = { 
                              name: "Detox tea",
                              price: 10.99,
                              status: "active",
                              frequency: "biweekly"
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

    context 'if the customer does not exist' do
      it 'will return an error message' do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = { 
                                name: "Detox tea",
                                price: 10.99,
                                status: "active",
                                frequency: "biweekly"
                              }
                              
        headers = { "CONTENT_TYPE": "application/json"}

        expect(Subscription.count).to eq(0)
        expect(customer.subscriptions.count).to eq(0)

        post "/api/v1/customers/#{Customer.last.id+1}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
        tea_subscription_response = JSON.parse(response.body, symbolize_names: true)
 
        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(Subscription.count).to eq(0)
        expect(customer.subscriptions.count).to eq(0)

        expect(tea_subscription_response).to have_key(:error)
        expect(tea_subscription_response[:error]).to be_an(Array)

        expect(tea_subscription_response[:error][0]).to have_key(:title)
        expect(tea_subscription_response[:error][0][:title]).to be_a(String)

        expect(tea_subscription_response[:error][0]).to have_key(:status)
        expect(tea_subscription_response[:error][0][:status]).to be_a(String)
      end
    end

    context 'if the item does not exist' do
      it 'will return an error message' do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = { 
                                name: "Detox tea",
                                price: 10.99,
                                status: "active",
                                frequency: "biweekly"
                              }
                              
        headers = { "CONTENT_TYPE": "application/json"}

        expect(Subscription.count).to eq(0)
        expect(customer.subscriptions.count).to eq(0)

        post "/api/v1/customers/#{customer.id}/teas/#{Tea.last.id+1}/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
        tea_subscription_response = JSON.parse(response.body, symbolize_names: true)
 
        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(Subscription.count).to eq(0)
        expect(customer.subscriptions.count).to eq(0)

        expect(tea_subscription_response).to have_key(:error)
        expect(tea_subscription_response[:error]).to be_an(Array)

        expect(tea_subscription_response[:error][0]).to have_key(:title)
        expect(tea_subscription_response[:error][0][:title]).to be_a(String)

        expect(tea_subscription_response[:error][0]).to have_key(:status)
        expect(tea_subscription_response[:error][0][:status]).to be_a(String)
      end
    end
  end
end