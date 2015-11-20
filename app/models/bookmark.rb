class Bookmark < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :topic, presence: true
  validates :url, presence: true, :uniqueness => {:scope => :topic_id}
  validates :user, presence: true
end
