require 'rubygems'
require 'rake'
require 'rufus/scheduler'


scheduler = Rufus::Scheduler.start_new

scheduler.cron '00 00 10 * * *' do
  @emails = Subscribe.select('email').map{ |s| s.email}
  @emails.each do |email|
    Subscription.send_updates(email).deliver
  end
end

# scheduler.every '10s' do
#   @emails = Subscribe.select('email').map{ |s| s.email}
#   @emails.each do |email|
#     Subscription.send_updates(email).deliver
#   end
# end

scheduler.cron '00 12 18 * * *' do
  deals = Deal.all
  puts("hello")
  deals.each do |deal|
    deal.check_visibility
    deal.save
  end
end