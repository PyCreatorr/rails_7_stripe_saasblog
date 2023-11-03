class Post < ApplicationRecord

    validates :title, :content, presence: true

    scope :free, -> {where(premium: false)}

    # class Book
    #     scope :with_long_title, ->(length = 20) { where("LENGTH(title) > ?", length) }
    # end

    def to_s
        title
    end

    
end
