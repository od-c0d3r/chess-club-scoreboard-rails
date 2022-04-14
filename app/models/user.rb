class User < ApplicationRecord
    has_many :wins, as: :winner, class_name: 'Match'
    has_many :losses, as: :loser, class_name: 'Match'
end
