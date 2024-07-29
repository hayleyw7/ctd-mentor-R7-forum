class SubscriptionsController < ApplicationController
  before_action :set_forum, only: [:new, :create]
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  def index
    @subscriptions = Subscription.all
  end

  def new
    @subscription = @forum.subscriptions.new
  end

  def create
    @subscription = @forum.subscriptions.new(subscription_params)
    if @subscription.save
      redirect_to @subscription, notice: 'Subscription was successfully created.'
    else
      render :new
    end
  end

  def show
    # @subscription is set by set_subscription
  end

  def edit
    # @subscription is set by set_subscription
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to @subscription, notice: 'Subscription was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subscription.destroy
    redirect_to forums_url, notice: 'Subscription was successfully destroyed.'
  end

  private

  def set_forum
    @forum = Forum.find(params[:forum_id])
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:user_id, :forum_id, :priority)
  end
end
