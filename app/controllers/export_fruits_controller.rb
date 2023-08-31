require 'csv'

class ExportFruitsController < ApplicationController
  def new
  end

  def create
    if all_params_empty?
      redirect_to new_export_fruit_path, alert: "Please provide at least one parameter."
    elsif name_zip_params_empty?
      redirect_to new_export_fruit_path, alert: "Please provide a file name."
    else
      service = FruitsApiService.new(fruit_params)
      @fruits = service.fetch_fruits
    end
  end

  private

  def fruit_params
    params.permit(:family, :genus, :order, :name_zip, :name_fruit)
  end

  def all_params_empty?
    fruit_params.values.all?(&:blank?)
  end

  def name_zip_params_empty?
    fruit_params[:name_zip].blank?
  end
end

