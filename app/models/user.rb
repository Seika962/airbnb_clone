class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :fullname, presence: true, length: { maximum: 50 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable


  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    # look for user by email and if it exists, return. if not, get those information after "else" from auth(facebook)
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user| # if exist, get the first one, if not create new one
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.fullname = auth.info.name  # assuming the user model has a name
        user.image = auth.info.image  # assuming the user model has an image
        user.uid = auth.uid  # uid is the user_id from auth
        user.provider = auth.provider
        # If you are using confirmable and the provider(s) you user validate emails,
        # uncomment the line below to skip the confirmation emails.
        user.skip_confirmation!
      end
    end
  end
end
