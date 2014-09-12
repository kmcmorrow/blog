class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  has_and_belongs_to_many :articles

  scope :sort_alphabetically, -> { order(name: :asc) }
end
