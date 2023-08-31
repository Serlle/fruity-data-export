require 'csv'

class ExportFruitsController < ApplicationController
  def new
  end

  def create
    if all_params_empty?
      redirect_to new_export_fruit_path, alert: "Please provide at least one parameter."
    elsif name_zip_params_empty?
      redirect_to new_export_fruit_path, alert: "Please provide a file name."
    elsif filters_empty?
      redirect_to new_export_fruit_path, alert: "Please provide at least one parameter.."
    else
      service = FruitsApiService.new(fruit_params)
      @fruits = service.fetch_fruits
      
      if @fruits.present?
        csv_filename = "#{params[:name_zip]}.csv"
        send_data create_csv(@fruits),
          type: 'text/csv; charset=iso-8859-1; header=present', 
          disposition: "attachment; filename=#{csv_filename}.csv"
      else
        redirect_to new_export_fruit_path, alert: "No fruits found."
      end
    end
  end

  private

  def fruit_params
    params.permit(:family, :genus, :order, :name_zip, :name_fruit)
  end

  def all_params_empty?
    fruit_params.values.all?(&:blank?)
  end

  def filters_empty?
    fruit_params.except(:name_zip).values.all?(&:blank?)
  end

  def name_zip_params_empty?
    fruit_params[:name_zip].blank?
  end

  def create_csv(fruits)
    CSV.generate(headers: true, col_sep: ' | ')  do |csv|
      csv << ["Name", "Family", "Genus", "Order"]

      @fruits.each do |fruit|
        csv << [fruit["name"], fruit["family"], fruit["genus"], fruit["order"]]
      end
    end 
  end
end

