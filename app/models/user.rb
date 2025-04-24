class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # ユーザ名が空でなく、かつ2文字以上の名前を要求するよう設定。
  validates :name, presence: true
  has_many :books, dependent: :destroy
end
