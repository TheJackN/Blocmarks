class Topic < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :bookmarks

  validates :title, presence: true, :uniqueness => { :scope => :user_id }
  validates :user, presence: true
end
