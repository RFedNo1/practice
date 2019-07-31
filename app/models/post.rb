class Post < ApplicationRecord
    validates :content, presence: true, length:{maximum: 5}
end
