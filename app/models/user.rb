# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  email                 :string           not null
#  age                   :integer          not null
#  political_affiliation :string           not null
#
class User < ApplicationRecord # Classnames and filenames are singular
    validates :username, :email, :age, presence: true, uniqueness: true
               # column names,        validation rules

    has_many :chirps, # method name that we will have access to
        primary_key: :id,
        foreign_key: :author_id, # same as belongs_to
        class_name: :Chirp # class name that this association points to

    has_many :likes, 
        primary_key: :id, 
        foreign_key: :liker_id, 
        class_name: :Like
    
    has_many :liked_chirps, 
        through: :likes,
        source: :chirp




end
