class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_one :location, dependent: :destroy

  after_create :chat_coords

  def chat_coords
    longitude = self.longitude.to_f
    latitude = self.latitude.to_f
    self.update_attributes(longitude: longitude, latitude: latitude)
  end

  # def self.chat_radius(coord1, coord2)
  #   distance = Geocoder::Calculations.distance_between(coord1, coord2)
  #   if distance <= 10
  #     return true
  #   else
  #     return false
  #   end
  # end

end
