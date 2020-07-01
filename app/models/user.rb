# == Schema Information
#
# Table name: users
#
#  id       :bigint           not null, primary key
#  username :string           not null
#  email    :string           not null
#
class User < ApplicationRecord # Classnames and filenames are singular
    validates :username, :email, presence: true, uniqueness: true
               # column names,        validation rules

    has_many :chirps, # method name that we will have access to
        primary_key: :id,
        foreign_key: :author_id, # same as belongs_to
        class_name: :Chirp # class name that this association points to

    
    
end
