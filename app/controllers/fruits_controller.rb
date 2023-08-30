class FruitsController < ApplicationController
  def new_csv
  end

  def create_csv
  end

  private
  
  def fruit_params
    params.permit(:family, :genus, :name_zip, :name_fruit)
  end

end
