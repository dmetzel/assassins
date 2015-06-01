class Game < ActiveRecord::Base
has_many :kills
has_many :enrollments
has_many :users, :through => :enrollments

end
