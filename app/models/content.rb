class Content < ActiveRecord::Base
  attr_accessible :body, :name, :title, :published
  validates_uniqueness_of :name
end
