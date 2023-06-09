require 'rails_helper'

describe 'PATCH /customers/:customer_id/teas/:tea_id/subscriptions/:subscription_id' do
  context 'if the customer updates their tea subscription' do
    it 'will change the status of their tea subscription' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, customer_id: customer.id, tea_id: tea.id, status: 0)

      old_subscription_status = Subscription.last.status

      subscription_params = { status: 1 }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/customers/#{customer.id}/teas/#{tea.id}/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate({subscription: subscription_params}) 
      response_body = JSON.parse(response.body, symbolize_names: true)

      new_subscription = Subscription.find_by(id: subscription.id)
      expect(response).to be_successful
      expect(new_subscription.status).to eq("cancelled")
      expect(new_subscription.status).to_not eq("active")
    end
  end
  
  context 'if the customer does not exist' do
    it 'will return an error message' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, customer_id: customer.id, tea_id: tea.id, status: 0)

      old_subscription_status = Subscription.last.status

      subscription_params = { status: 1 }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/customers/#{Customer.last.id+1}/teas/#{tea.id}/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate({subscription: subscription_params}) 
      response_body = JSON.parse(response.body, symbolize_names: true)
    
      new_subscription = Subscription.find_by(id: subscription.id)

      expect(new_subscription.status).to_not eq("cancelled")
      expect(new_subscription.status).to eq("active")

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to be_an(Array)

      expect(response_body[:error][0]).to have_key(:title)
      expect(response_body[:error][0][:title]).to be_a(String)
      expect(response_body[:error][0][:title]).to match(/Couldn't find Customer with 'id'=#{Customer.last.id+1}/)

      expect(response_body[:error][0]).to have_key(:status)
      expect(response_body[:error][0][:status]).to be_a(String)
    end
  end
end
