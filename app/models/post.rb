class Post < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    belongs_to :topic

    default_scope { order('title ASC') }
    scope :reverse_created_at, -> { order('created_at DESC') }
end
