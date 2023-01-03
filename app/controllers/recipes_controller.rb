class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authorize_recipe, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 10)
    if @recipes.empty?
      if logged_in?
        flash.now[:notice] = "There are no recipes yet. Create one now!"
      else
        flash.now[:notice] = "There are no recipes yet. Sign in to create one."
      end
    end
  end

  def show
    @ingredients = @recipe.ingredients
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Recipe was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: "Recipe was successfully deleted."
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def authorize_recipe
    unless @recipe.user == current_user
      redirect_to root_url, alert: "You are not authorized to perform this action."
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :title, :description, :image, ingredients_attributes: [:id, :name, :measurement_unit, :_destroy])
  end
end
