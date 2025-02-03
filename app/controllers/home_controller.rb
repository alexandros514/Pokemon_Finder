class HomeController < ApplicationController
  def index
    search_for_value = params[:q]
    if search_for_value.present?
      resp = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{search_for_value}/")
      if resp.code == 404
        return  redirect_to root_path
      end
      @pokemon = resp
      @pokemon_image = @pokemon["sprites"]["front_default"]
      @pokemon_name = @pokemon["name"]
      @pokemon_ability = @pokemon["abilities"].map{|ability_hash| ability_hash["ability"]["name"]}.join(",")
      @pokemon_types = @pokemon["types"].map{|type_hash| type_hash["type"]["name"]}.join(",") #[0]["type"]["name"]
      @pokemon_exp = @pokemon["base_experience"]
      @pokemon_weight =@pokemon["weight"]
    end

    search_tcg = @pokemon_name
    resp_tcg = HTTParty.get("https://api.pokemontcg.io/v2/cards?q=!name:#{search_tcg}")
    @pokemonTcg = resp_tcg
    @pokemonTcg_na


  end
end
