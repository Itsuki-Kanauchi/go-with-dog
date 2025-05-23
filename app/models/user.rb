class User < ApplicationRecord
  # エラーメッセージの順番を制御するために先頭に記載（エラーメッセージはバリデーション順に記載されるため）
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, length: { maximum: 255 }

  has_many :posts, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
