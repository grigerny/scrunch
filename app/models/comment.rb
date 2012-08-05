class Comment < ActiveRecord::Base
  attr_accessible :body, :name, :user_id
  belongs_to :provider
  belongs_to :user
end
