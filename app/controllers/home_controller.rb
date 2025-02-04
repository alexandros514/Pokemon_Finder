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
      @pokemon_image_shiny = @pokemon["sprites"]["front_shiny"]
      @pokemon_name = @pokemon["name"]
      @pokemon_ability = @pokemon["abilities"].map{|ability_hash| ability_hash["ability"]["name"]}.join(" & ")
      @pokemon_types = @pokemon["types"].map{|type_hash| type_hash["type"]["name"]}.join(" & ") #[0]["type"]["name"]
      @pokemon_exp = @pokemon["base_experience"]
      @pokemon_weight =@pokemon["weight"]

    search_tcg = @pokemon_name
    resp_tcg = HTTParty.get("https://api.pokemontcg.io/v2/cards?q=!name:#{search_tcg}")
      if resp_tcg.code != 404
        @pokemon_tcg = resp_tcg
        @pokemon_tcg_images = @pokemon_tcg["data"].map{|tcgplayer_hash| tcgplayer_hash["images"]["small"]}
        @pokemon_tcg_images_core =@pokemon_tcg["data"].first["images"]["large"]
        @pokemon_tcg_txt = @pokemon_tcg["data"].first["flavorText"]
      end

    end

  end
end
