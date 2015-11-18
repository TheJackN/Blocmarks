class Bookmark < ActiveRecord::Base
  belongs_to :topic, dependent: :destroy

  validates :topic, presence: true
  validates :url, presence: true, :uniqueness => {:scope => [:user_id, :topic_id]}
end
