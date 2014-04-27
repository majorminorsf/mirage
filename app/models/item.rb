class Item < ActiveRecord::Base
  attr_accessible :order_id, :quantity, :strain_id, :price
  belongs_to :order
  
  def strain
    Strain.find(self.strain_id)
  end
  def total
    price*quantity
  end
end
