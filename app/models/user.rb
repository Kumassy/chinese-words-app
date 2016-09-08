class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]

	attr_accessor :login
	
	validates :username,
	  uniqueness: { case_sensitive: :false },
	  length: { minimum: 4, maximum: 20 },
	  format: { with: /\A[a-z0-9]+\z/, message: "ユーザー名は半角英数字です"}

  validates :role,
    inclusion:{
      in: ["viewer","editor","manager"]
    }

  has_and_belongs_to_many :words


	def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions.to_h).first
    end
  end


end
