class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable

#  validates :password, presence: { message: "Vul een password in"},
#            length: { minimum: 6, maximum: 128, message: "Je password moet minimaal 6 karakters hebben" }
#  validates :password_confirmation, presence: { message: "Vul je password opnieuw in"}
  validates :fullname, presence: true, length: {maximum: 50}
  validates :phone_number, 
            presence: { message: "Vul een telefoonnummer in" },
            length: { minimum: 10, maximum: 15, message: "Telefoonnummer: Vul 10 cijfers in" },
            numericality: { only_integer: true, message: "Telefoonnummer: Vul enkel cijfers in" }         

  has_many :trainings
  has_many :thrills, through: :trainings
  has_many :reservations
  has_many :reviews

  def self.from_omniauth(auth)
  	user = User.where(email: auth.info.email).first

  	if user 
  		return user
  	else
  		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	  		user.fullname = auth.info.name
        user.provider = auth.provider
	  		user.uid = auth.uid
	  		user.email = auth.info.email
	  		user.image = auth.info.image
	  		user.password = Devise.friendly_token[0,20]
  		end
  	end	
  end
end
