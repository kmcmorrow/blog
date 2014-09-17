class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  has_many :comments
  has_and_belongs_to_many :categories

  def self.containing_string(search_string)
    where("title LIKE ?", "%#{search_string}%")
  end
end
