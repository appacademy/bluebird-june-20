# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  email                 :string           not null
#  age                   :integer          not null
#  political_affiliation :string
#  password_digest       :string           not null
#  session_token         :string           not null
#
class User < ApplicationRecord # Classnames and filenames are singular
    # validates :email, :session_token, presence: true, uniqueness: true
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :age, :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}
    # validations require a getter method for the attribute
    # validations are called during .save

    # before_validation # happens after .save but before validations
    after_initialize :ensure_session_token # happens after .new

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

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.check_password?(password)
            user
        else
            nil
        end
    end

    def check_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        # ^ takes password_digest and returns BCrypt password instance
        password_object.is_password?(password)
        # ^ checks if instance was generated from password, returns true or false
    end

    # everytime we instantiate a new rails object, rails will call the setter
    # method for all attributes called in the .new
    def password=(password)
        # puts "this is the password setter"
        @password = password
        self.password_digest = BCrypt::Password.create(password) 
        # ^ creates password_digest from password
    end

    # getter used during validation
    def password
        # puts "this is the password getter"
        @password
    end

    def ensure_session_token
        # puts "this is setting your session_token"
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64 # new session_token
        self.save!                                        # save it to db
        self.session_token                                # return it!
    end



end
