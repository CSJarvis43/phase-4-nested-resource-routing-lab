class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # def index
  #   items = Item.all
  #   render json: items, include: :user
  # end

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created
  end


  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response(e)
    render json: { error: "#{e}"}, status: :not_found
  end



end
