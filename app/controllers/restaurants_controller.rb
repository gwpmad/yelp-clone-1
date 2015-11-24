class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

  def new
    @restaurant = Restaurant.new
  end

  def restaurant_params
    #only allow the field labelled 'name' to be accepted by the form
    params.require(:restaurant).permit(:name)
  end
end
