class Order < ActiveRecord::Base
  attr_accessible :member_id, :total, :processed
  has_many :items
  belongs_to :member
  
  def add_item(strain, quantity)
    item = self.items.where('strain_id = ?', strain.id).first
    if item
      item.quantity += quantity
      item.save
    else
      self.items << Item.new(strain_id: strain.id, quantity: quantity, price: strain.price)
    end
    self.update(total: order_total(self))
  end
  
  def order_total(order)
    total = 0
    order.items.each do |i|
      total += i.quantity*i.price
    end
    total
  end
end
