class FruitsApiService
  BASE_URL = "https://www.fruityvice.com/".freeze

  def initialize(params)
    @params = params
  end

  def fetch_fruits
    conn = Faraday.new(BASE_URL) do |f|
      f.request :json # encode req bodies as JSON
      f.response :json # decode response bodies as JSON
    end

    response = []

    # Search by name
    name_fruit = @params[:name_fruit]
    if name_fruit.present?
      response = fetch_fruit_by_name(conn, name_fruit.capitalize)
      return { body: response }
    end
    
    # Search by filter
    @params.except(:name_zip, :name_fruit).each do |key, value| 
      if value.present?
        api_response = conn.get("/api/fruit/#{key}/#{value}")
        status = api_response.status
        if status == 200
          response.concat(api_response.body)
        else   
          return { error: api_response.body["error"] }
        end
      end
    end
    
    return { body: response }    
  end

  private
  
  def fetch_fruit_by_name(conn, name)
    api_response = conn.get("/api/fruit/all").body
    api_response.select { |fruit| fruit["name"] == name }
  end

end