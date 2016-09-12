class Training < ActiveRecord::Base

# was ApplicationRecord

  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews
  has_many :thrills
  has_many :users, through: :thrills

  geocoded_by :tr_location
  after_validation :geocode, if:  :tr_location_changed?

#  validates :tr_type, presence: false
#  validates :tr_intensity, presence: false
  validates :tr_name, 
            presence: { message: "Trainingsnaam: Vul een naam in voor je training" }, 
            length: { maximum: 50, message: "Trainingsnaam: Gebruik max. 50 tekens voor je trainingsnaam" }
  validates :tr_description, presence: { message: "Beschrijving: Vul een beschrijving van je training in" }
  validates :tr_location, presence: { message: "Locatie: Vul een locatie van je training in" }
#  validates :tr_time, presence: false
  validates :tr_max_attendants, 
            presence: { message: "Aantal deelnemers: Vul een maximaal aantal deelnemers in" },
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100, message: "Aantal deelnemers: Vul een aantal deelnemers tussen 0 en 100 in" }
  validates :tr_price, 
            presence: { message: "Prijs: Vul een prijs van je training in" },
            numericality: { greater_than_or_equal_to: 1, message: "Prijs: Vul een prijs in groter dan € 1 en gebruik een . om centen aan te geven" }
  validates :tr_duration, 
            presence: { message: "Trainingsduur: Vul een trainingsduur in" },
            numericality: { only_integer: true, greater_than: 5, message: "Trainingsduur: Zorg dat je training langer is dan 5 minuten" }
  validates :tr_gender, presence: { message: "Voor wie: Geef aan voor wie je training is" }
  validates :tr_active, acceptance: { message: "Je moet de voorwaarden accepteren om een training aan te maken" }

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end
