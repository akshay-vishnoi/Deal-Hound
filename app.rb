require 'rubygems'
require 'sinatra'
require 'braintree'
require 'debugger'


Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = "s3z8g2x4x2cv4rgm"
Braintree::Configuration.public_key = "mjwcs535zr8sxp3f"
Braintree::Configuration.private_key = "a4713aba9c72d74342871a1c06a64f0d"

get "/" do
  # erb :braintree

  # t = Braintree::Transaction.find "2ymbmb"
  # debugger
  # puts "hell"
  # clone transaction
  # result = Braintree::Transaction.clone_transaction(
  #   '2ymbmb',
  #   amount: '10',
  #   options: {
  #     submit_for_settlement: true
  #   }
  # )
end

post "/create_transaction" do
  debugger
  result = Braintree::Transaction.sale(
    :amount => "1000.00",
    :credit_card => {
      :number => params[:number],
      :cvv => params[:cvv],
      :expiration_month => params[:month],
      :expiration_year => params[:year]
    },
    :options => {
      :submit_for_settlement => true
    }
  )

  if result.success?
    "<h1>Success! Transaction ID: #{result.transaction.id}</h1>"
  else
    "<h1>Error: #{result.message}</h1>"
  end
end

post '/create_customer' do
  result = Braintree::Customer.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    credit_card: {
      billing_address: {
        postal_code: params[:postal_code]
      },
      number: params[:number],
      expiration_month: params[:month],
      expiration_year: params[:year],
      cvv: params[:cvv]
    }
  )
  if result.success?
    "<h1>Customer created with name: #{result.customer.first_name} #{result.customer.last_name}</h1>" +
    "<br /><a href=\"/subscriptions?id=#{result.customer.id}\">Click here to sign this Customer up for a recurring payment</a>"
  else
    "<h1>Error: #{result.message}</h1>"
  end
end

get '/subscriptions' do
  begin
    customer = Braintree::Customer.find(request.params['id'])
    payment_method_token = customer.credit_cards[0].token
    result = Braintree::Subscription.create(
      payment_method_token: payment_method_token,
      plan_id: "plan_1"
    )
    if result.success?
        "<h1>Subscription Status #{result.subscription.status}"
    else
      "<h1>Error: #{result.message}</h1>"
    end
  rescue Braintree::NotFoundError
    "<h1>No customer found for id: #{request.params["id"]}"
  end
end

















# result = Braintree::Transaction.sale(
#   :amount => "100.00",
#   :order_id => "order id",
#   :merchant_account_id => "a_merchant_account_id",
#   :credit_card => {
#     :number => "5105105105105100",
#     :expiration_date => "05/2012",
#     :cardholder_name => "The Cardholder",
#     :cvv => "cvv"
#   },
#   :customer => {
#     :first_name => "Drew",
#     :last_name => "Smith",
#     :company => "Braintree",
#     :phone => "312-555-1234",
#     :fax => "312-555-1235",
#     :website => "http://www.example.com",
#     :email => "drew@example.com"
#   },
#   :billing => {
#     :first_name => "Paul",
#     :last_name => "Smith",
#     :company => "Braintree",
#     :street_address => "1 E Main St",
#     :extended_address => "Suite 403",
#     :locality => "Chicago",
#     :region => "Illinois",
#     :postal_code => "60622",
#     :country_code_alpha2 => "US"
#   },
#   :shipping => {
#     :first_name => "Jen",
#     :last_name => "Smith",
#     :company => "Braintree",
#     :street_address => "1 E 1st St",
#     :extended_address => "Suite 403",
#     :locality => "Bartlett",
#     :region => "Illinois",
#     :postal_code => "60103",
#     :country_code_alpha2 => "US"
#   },
#   :options => {
#     :submit_for_settlement => true
#   }
# )

# Month and year separately
  # result = Braintree::Transaction.sale(
  #   :amount => "10.00",
  #   :credit_card => {
  #     :number => "5105105105105100",
  #     :expiration_month => "05",
  #     :expiration_year => "2012",
  #   }
  # )

# Country with alpha 2-code, 3-code, numeric-code or using full name
  # result = Braintree::Transaction.sale(
  #   :amount => "100.00",
  #   :credit_card => {
  #     :number => "5105105105105100",
  #     :expiration_date => "05/2012",
  #   },
  #   :billing => {
  #     :country_code_alpha2 => "US" | "USA" | "840" | "United States of America"
  #   }
  # )

# to store into the vault
# provide customer id and credit card taken
  # result = Braintree::Transaction.sale(
  #   :amount => "10.00",
  #   :credit_card => {
  #     :token => "a_token",
  #     :number => "5105105105105100",
  #     :expiration_date => "05/2012",
  #   },
  #   :customer => {
  #     :id => "a_customer_id"
  #   },
  #   :billing => {
  #     :postal_code => "60090"
  #   },
  #   :shipping => {
  #     :street_address => "1 E Main St",
  #     :locality => "Chicago",
  #     :region => "Illinois",
  #     :postal_code => "60622"
  #   },
  #   :options => {
  #     :store_in_vault => true,
  #     :add_billing_address_to_payment_method => true,
  #     :store_shipping_address_in_vault => true
  #   }
  # )

# Create transaction from vault using customer_id
  # result = Braintree::Transaction.sale(
  #   :amount => "10.00",
  #   :customer_id => "the_customer_id",
  #   :payment_method_token => "the_payment_method_token"
  # )