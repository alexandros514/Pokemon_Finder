class HomeController < ApplicationController
  def index
    search_for_value = params[:q]
    if search_for_value.present?
      resp = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{search_for_value}/")
      @pokemon = resp
      @pokemon_image = @pokemon["sprites"]["front_default"]
      @pokemon_name = @pokemon["name"]
      @pokemon_ability = @pokemon["abilities"]

    else

    end
  end
end
