class TripSerializer < ActiveModel::Serializer
  attributes :name, :start_date, :end_date, :imageurl, :user_id
  belongs_to :user
  # belongs_to :location, serializer: LocationSerializer
end
