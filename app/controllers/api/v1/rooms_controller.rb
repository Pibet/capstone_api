module Api
  module V1
    class RoomsController < ApplicationController
      before_action :set_room, only: %i[show destroy]

      def index
        rooms = Room.order(:id)
        render json: { data: rooms }, status: :ok
      end

      def show
        render json: { data: @room }, status: :ok
      end

      def create
        room = Room.new(room_params)
        if room.save
          render json: { data: room }, status: :created
        else
          render json: {
            error: {
              code: "VALIDATION_ERROR",
              message: "Data tidak valid",
              fields: room.errors.to_hash
            }
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @room.destroy!
        head :no_content
      end

      private

      def set_room
        @room = Room.find(params[:id])
      end

      def room_params
        params.require(:room).permit(:name, :capacity, :available, :description)
      end
    end
  end
end
