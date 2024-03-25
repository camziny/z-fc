module Api
  module V1
    class PlayersController < ApplicationController
      def index
        @players = Player.all
        render json: @players
      end
    end
  end
end
