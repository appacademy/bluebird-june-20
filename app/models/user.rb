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
    validates :username, :email, presence: true, uniqueness: true
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

    
    #ActiveRecord finder methods
    
    User.first
    User.last
    User.find(1)
    User.find_by(username: 'wakka_wakka')

    #Write a query to look for all the users between the ages of 10-20

    User.where("age >= 10 AND age <= 20")
    User.where(age: 10..20) #inclusive
    User.where(age: 10...21) #exclusive

    #Find all the users not younger than the age of 11
    #HINT: where not

    User.where.not("age <= 11")
    User.where.not("age <= ?", 11)

    #Find all the instructors from a list and order by ascending
    instructors = ["dean_machine", "michelle_bell", "wakka_wakka"]
    # all users are instructors

    User.where("username IN instructors") #username: 'instructors'
    User.where("username IN (?)", instructors) #need the parens because it's a list of instructors we are passing in
    User.where(username: instructors)


end
