class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def active_for_authentication? active_for_authentication?はdeviseにデフォルトであるクラスメソッドでboolean型を返す。
  #   super && (is_valid == false)  このメソッドがfalseになるとログインできなくなる。この記述だけしてれば、sessions_controllerに用意している退会用メソッド
  # end                              のbefore_actionはいらない。けれどredirect先が設定されているbefore_actionの方がいいかも

  has_many :cart_items, dependent: :destroy
  has_many :orders
  has_many :addresses

  
  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
    validates :postal_code
    validates :address
    validates :phone_number
    validates :email
  end
end
