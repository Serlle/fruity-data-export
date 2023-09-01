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
    params = {
      family: @params["family"],
      genus: @params["genus"],
      order: @params["order"]
    }

    params.each do |key, value| 
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
end