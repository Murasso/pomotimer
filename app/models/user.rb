class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :study_records, dependent: :destroy
  has_one_attached :profile_image

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/girl_avatar1.jpg")
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end
    def self.from_omniauth(auth)
       sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
       user = User.where(email: auth.info.email).first_or_initialize(
          name: auth.info.name,
          email: auth.info.email
        )
    
      # userが登録済みであるか判断
       if user.persisted?
   
         sns.user = user
         sns.save
       end
       user
    end
end
