class OrderDetail < ApplicationRecord
  
  enum production_status: {
                    not_startable: 0,
                    waiting_production: 1,
                    now_production: 2,
                    finish_production: 3
  }
  
  belongs_to :order
  belongs_to :item
end
