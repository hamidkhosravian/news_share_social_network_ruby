class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2]

   include Auth

   enum role: [:register, :block]
   validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

   has_many :auth_tokens, as: :tokenable, autosave: true

   after_initialize :set_roles

   private
     def set_roles
       self.role ||= :register if self.new_record?
     end
end
