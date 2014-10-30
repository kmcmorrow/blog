class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  has_many :comments
  has_and_belongs_to_many :categories

  enum status: [:draft, :published]

  default_scope { order('created_at DESC') }

  def self.containing_string(search_string)
    where("title LIKE ? OR text LIKE ?",
          "%#{search_string}%", "%#{search_string}%")
  end
end
