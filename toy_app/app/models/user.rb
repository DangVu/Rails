class User < ActiveRecord::Base
	has_many :microposts
	validates_presence_of :name, :email
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
