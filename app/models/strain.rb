class Strain < ActiveRecord::Base
  attr_accessible :strain, :name, :thc, :cbd, :published, :photo, :description, :rating, :rates, :price, :featured
  has_attached_file :photo, styles: {thumb: "x80", menu: "410x"}
end
