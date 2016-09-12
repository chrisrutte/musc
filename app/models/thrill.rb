class Thrill < ApplicationRecord
  belongs_to :training
  has_many :reservations
  has_many :users, through: :reservations

  validates :thrilldate, presence: true
  validates :thrillhr, presence: false
  validates :thrillmin, presence: false
  validates :time, presence: true
  
end
