class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, :uniqueness => { :scope => :user_id }
  validates :user, presence: true
end
