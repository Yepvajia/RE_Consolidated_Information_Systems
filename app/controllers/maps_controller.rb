class MapsController < ApplicationController
  def index
    @addresses = Address.all
    @hash = Gmaps4rails.build_markers(@addresses) do |address, marker|
      marker.lat address.lat
      marker.lng address.lng
    end
  end
end
