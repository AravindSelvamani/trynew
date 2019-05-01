class Category < ApplicationRecord
  validates :name, length: { minimum:3, maximum:30 }
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end
