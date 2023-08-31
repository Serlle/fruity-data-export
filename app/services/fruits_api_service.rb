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

    response = conn.get do |req|
      req.url("/api/fruit/family/#{@params["family"]}") if @params["family"].present?
      req.url("/api/fruit/genus/#{@params["genus"]}") if @params["genus"].present?
      req.url("/api/fruit/order/#{@params["order"]}") if @params["order"].present?
    end
  
    return response.body
  end
end