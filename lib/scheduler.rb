require 'rubygems'
require 'rake'
require 'rufus/scheduler'


scheduler = Rufus::Scheduler.start_new

# scheduler.cron '00 00 10 * * *' do
#   @emails = Subscribe.select('email').map{ |s| s.email}
#   @emails.each do |email|
#     Subscription.send_updates(email).deliver
#   end
# end

# scheduler.every '2m' do
#   @emails = Subscribe.select('email').map{ |s| s.email}
#   @emails.each do |email|
#     Subscription.send_updates(email).deliver
#   end
# end