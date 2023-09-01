require 'csv'

class ExportFruitsController < ApplicationController
  def new
  end

  def create
    return redirect_to new_export_fruit_path, alert: "Blank fields. Please provide a CSV file name and at least one filter." if all_params_empty?
    return redirect_to new_export_fruit_path, alert: "Please provide a CSV file name." if name_zip_params_empty?
    return redirect_to new_export_fruit_path, alert: "Please provide at least one filter." if filters_empty?

    api = FruitsApiService.new(fruit_params)
    fruits = api.fetch_fruits

    if fruits.key?(:error)
      redirect_to new_export_fruit_path, alert: fruits[:error]
    else
      csv_filename = "#{fruit_params[:name_zip]}.csv"
      csv = CsvService.new(fruits)
      format_csv = csv.generate_format_csv(fruits)

      flash[:alert] = "File Created."
      respond_to do |format|
        format.html
        format.csv { send_data format_csv, type: 'text/csv; charset=iso-8859-1; header=present', disposition: "attachment; filename=#{csv_filename}" }
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
end

