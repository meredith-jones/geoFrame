class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_one :location, dependent: :destroy

  before_save :chat_coords

  def chat_coords
    results = []
    coordinates = request.location.coordinates
    results << coordinates[0].data['longitude']
    results << coordinates[0].data['latitude']
    self.location = results
  end

end
