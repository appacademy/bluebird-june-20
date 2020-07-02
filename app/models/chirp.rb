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

    has_many :likes,
        primary_key: :id, 
        foreign_key: :chirp_id, 
        class_name: :Like
    
    has_many :likers,
        through: :likes,
        source: :liker

    def body_too_long
        # Rails gives us an implicit getter for column names. body == self.body
        # body returns the body of the chirp
        if body && body.length > 140
            errors[:body] << 'is too long.'
        end
    end

    # Includes #

    def self.see_chirp_authors_n_plus_one
        # the "+1"
        chirps = Chirp.all

        # the "N"
        chirps.each do |chirp|
        puts chirp.author.username
        end

    end

    def self.see_chirps_optimized
        # pre-fetches data
        chirps = Chirp.includes(:author).all

        chirps.each do |chirp| 
        # uses pre-fetched data 
        puts chirp.author.username
        end
    end

    # Joins #

    def self.see_chirp_num_likes_n_plus_one
        chirps = Chirp.all

        chirps.each do |chirp|
        puts chirp.likes.length
        end
    end

    def self.see_chirp_num_likes_optimized
        chirps_with_likes = Chirp
        .select("chirps.*, COUNT(*) AS num_likes")
        .joins(:likes)
        .group(:id)
    
        chirps_with_likes.each do |chirp|
        puts chirp.num_likes
        end
    end

end
