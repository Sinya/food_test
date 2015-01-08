class FoodsController < ApplicationController

  before_action :authenticate_user, only: [ :create, :index, :destroy ]
  
  def index
    @foods = Food.from_food_list(current_user).order('due ASC')
    @ingredient = Ingredient.first.name
  end

  def new
    @foods = Food.from_food_list(current_user).order('due ASC')
    @food = Food.new(params[:food])
    @food.user_id = current_user.id

  end

  def create
    @food = current_user.foods.build(create_params) 
    
    if @food.save
      flash[:success] = "Food successfully"
      redirect_to new_food_path
    else
      render "new"
    end
  end

  def destroy
  end

  def show
    @ingredients = Ingredient.all
  end

  def ask_for_food
    @ask = params[:myform][:comments]
    render :text => @ask 
  end

  # private

  def create_params
    params.require(:food).permit(:name, :category, :due)
  end

end
