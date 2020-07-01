# == Schema Information
#
# Table name: chirps
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chirp < ApplicationRecord
    # validates :body, :author_id, presence: true
    validates :body, presence: true
    validate :body_too_long # custom validation

    belongs_to :author, # this association creates a presence: true validation for the foreign key 
        primary_key: :id, # always is id
        foreign_key: :author_id,
        class_name: :User # can also be 'User'
        # optional: true, makes the association optional

    def body_too_long
        # Rails gives us an implicit getter for column names. body == self.body
        # body returns the body of the chirp
        if body && body.length > 140
            errors[:body] << 'is too long.'
        end
    end
end
