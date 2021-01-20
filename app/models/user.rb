class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, :birthday
    validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ } 
    validates :first_name_katakana, :last_name_katakana, format: { with: /\A[ァ-ヶ]+\z/ } 
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[\w-]{6,128}+\z/i }
  end
end
