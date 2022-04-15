class Match < ApplicationRecord
  validates_presence_of :player_one
  validates_presence_of :player_two
  validates_presence_of :result
  validates :player_one, comparison: { other_than: :player_two, message: "and Player two should be different" }

  belongs_to :player_one, class_name: 'User'
  belongs_to :player_two, class_name: 'User'
end
