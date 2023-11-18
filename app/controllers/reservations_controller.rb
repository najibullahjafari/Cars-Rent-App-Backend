# frozen_string_literal: true

module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :set_reservation, only: %i[show destroy]

      # GET
      def index
        @reservations = Reservation.all
        render json: @reservations
      end

      def show
        render json: @reservation
      end

      def create
        @reservation = Reservation.new(reservation_params)
        if @reservation.save
          render json: @reservation, status: :created
        else
          render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @reservation.destroy
          render json: { success: true, message: 'Reservation deleted' }
        else
          render json: { success: false, errors: @reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_reservation
        @reservation = Reservation.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def reservation_params
        params.require(:reservation).permit(:user_id, :car_id, :appointment_date)
      end
    end
  end
end
