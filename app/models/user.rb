class User < ApplicationRecord
    has_secure_password
    has_many :ideas, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_ideas, through: :likes, source: :idea
    
    before_validation :downcase_email

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates :password_digest, presence: true


    private

    def downcase_email
        self.email = self.email.downcase
    end
end
