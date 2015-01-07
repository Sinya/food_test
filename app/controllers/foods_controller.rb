class FoodsController < ApplicationController

  before_action :authenticate_user, only: [ :create, :index, :destroy ]
  
  def index
    @ingredient = Ingredient.first.name
  end

  def new
    @food = Food.new(params[:food])
    @food.user_id = current_user.id
  end

  def create
    @food = current_user.foods.build(create_params) 
    
    if @food.save
      flash[:success] = "Food successfully"
      redirect_to foods_path
    else
      render "new"
    end
  end

  def destroy
  end


  # private

  def create_params
    params.require(:food).permit(:name, :category, :due)
  end

end
