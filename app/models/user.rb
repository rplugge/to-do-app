class User < ActiveRecord::Base
  has_many :tasks
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
end