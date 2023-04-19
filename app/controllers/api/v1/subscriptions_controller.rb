class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: 201
  end

  def update
    customer = Customer.find(params[:customer_id])
    subscription = Subscription.find(params[:id])
    subscription.update!(update_params)
    render json: SubscriptionSerializer.new(subscription)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:name, :price, :status, :frequency, :customer_id, :tea_id).merge(customer_id: params[:customer_id], tea_id: params[:tea_id])
  end

  def update_params
    params.require(:subscription).permit(:status)
  end
end