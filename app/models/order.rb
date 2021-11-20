class Order < ApplicationRecord
  belongs_to :end_user
  has_many :order_details

	enum payment_method: {
		bank_transfer: 0 ,
	  credit_card: 1
	}
	
	enum order_status: {
		waiting_payment: 0,
		payment_confirmation: 1,
		in_production: 2,
		preparing_for_shipping: 3,
		sent: 4
		}

end
