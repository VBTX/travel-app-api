class Api::V1::TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]

  # GET /trips
  def index

    if logged_in?
    @trips = current_user.trips
    render json: @trips
  else
    render json: {
      error: "You must be logged in to see trips"
    }
  end
  end

  # GET /trips/1
  def show
    render json: @trip
  end

  # POST /trips
  def create
    # @trip = current_user.trips.build(trip_params)
    @trip = Trip.new(trip_params)

    if @trip.save
      render json: @trip, status: :created
    else

      error_resp = {
        error: @trip.errors.full_messages.to_sentence
      }
      render json: error_resp, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trips/1
  def update
    if @trip.update(trip_params)
      render json: @trip
    else
       error_resp = {
        error: @trip.errors.full_messages.to_sentence
      }
      render json: error_resp, status: :unprocessable_entity
    end
  end

  # DELETE /trips/1
  def destroy
    if @trip.destroy
      render json: {
        message: "Trip deleted!"
      }

    else

      error_resp = {
        error: "God knows what happened here!"
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date, :imageurl, :user_id)
    end
end
