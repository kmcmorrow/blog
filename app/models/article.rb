class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  has_many :comments
  has_and_belongs_to_many :categories
end
