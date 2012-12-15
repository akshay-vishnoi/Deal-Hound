# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
temp = User.where(:user_name => 'akshay-admin').first
unless temp
  User.create(:user_name => 'akshay-admin', :password => '11111111', :password_confirmation => "11111111", :email => "akshay.vishnoi@vinsol.com", :name => "Akshay Vishnoi", :mobile_no => '9968165609', :wallet => '50000', :admin => 1)
end