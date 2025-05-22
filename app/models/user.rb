class User < ApplicationRecord
  has_one_attached :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      'no_image'  # app/assets/images/no_image.pngを用意してください
    end
  end
end
