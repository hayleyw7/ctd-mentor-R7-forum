class SubscriptionsController < ApplicationController
  before_action :check_logon
  before_action :set_forum, only: [:new, :create]
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  def index
    @subscriptions = Subscription.where(user_id: @current_user.id).includes(:forum).order(:priority)
  end

  def new
    @subscription = @forum.subscriptions.new
  end

  def create
    @subscription = @forum.subscriptions.new(subscription_params)
    @subscription.user_id = @current_user.id

    if @forum.subscriptions.where(user_id: @current_user.id).exists?
      redirect_to forums_path, notice: "You are already subscribed to that forum."
    elsif @subscription.save
      redirect_to [@forum, @subscription], notice: 'Subscription was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to [@subscription.forum, @subscription], notice: 'Subscription was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    forum = @subscription.forum
    @subscription.destroy
    redirect_to forum_subscriptions_path(forum), notice: 'Subscription was successfully destroyed.'
  end

  private

  def set_forum
    @forum = Forum.find(params[:forum_id])
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:priority)
  end
end
