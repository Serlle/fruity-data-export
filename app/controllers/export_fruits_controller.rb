require 'csv'

class ExportFruitsController < ApplicationController
  before_action :validate_fields, only: [:create]

  def new
  end

  def create
    if @continue_create
      api = FruitsApiService.new(fruit_params)
      fruits = api.fetch_fruits

      if fruits.key?(:error)
        redirect_to new_export_fruit_path, alert: fruits[:error]
      else
        csv_filename = "#{fruit_params[:name_zip]}.csv"
        csv = CsvService.new(fruits)
        format_csv = csv.generate_format_csv

        respond_to do |format|
          format.html
          format.csv { send_data format_csv, type: 'text/csv; charset=iso-8859-1; header=present', disposition: "attachment; filename=#{csv_filename}" }
        end
      end
    end
  end

  private

  def fruit_params
    params.permit(:family, :genus, :order, :name_zip, :name_fruit)
  end

  def validate_fields
    if error_messages.present?
      redirect_to new_export_fruit_path, alert: error_messages
    else
      @continue_create = true
    end
  end

  def error_messages
    if fruit_params.values.all?(&:blank?)
      "Blank fields. Please provide a CSV file name and at least one filter." 
    elsif fruit_params[:name_zip].blank?
      "Please provide a CSV file name."
    elsif fruit_params.except(:name_zip).values.all?(&:blank?)
      "Please provide at least one filter."
    elsif fruit_params.except(:name_zip, :name_fruit).values.any?(&:present?) && fruit_params[:name_fruit].present?
      %{Please, only select one path: "Search by filter" or "Search by name".}
    end
  end
end