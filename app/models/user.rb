class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

   include Auth

   enum role: [:register, :block]
   validates :email, presence: true, uniqueness: { case_sensitive: false }
   has_many :auth_tokens, as: :tokenable, autosave: true

   after_initialize :set_roles

   private
     def set_roles
       if self.new_record?
         self.role ||= :register
       end
     end
end
