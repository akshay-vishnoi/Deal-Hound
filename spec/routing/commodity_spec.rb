require 'spec_helper'

describe "routing to commodities" do

  it "routes /commodities/:id to commodity#show for commodity_id" do
    {:get => "/commodities/1"}.should route_to(
      :controller => "commodities",
      :action => "show",
      :id => "1"
    )
  end
  
  it "routes to #index" do
    get("/commodities").should route_to("commodities#index")
  end

  it "routes to #new" do
    get("/commodities/new").should route_to("commodities#new")
  end

  it "routes to #show" do
    get("/commodities/1").should route_to("commodities#show", :id => "1")
  end

  it "routes to #edit" do
    get("/commodities/1/edit").should route_to("commodities#edit", :id => "1")
  end

  it "routes to #create" do
    post("/commodities").should route_to("commodities#create")
  end

  it "routes to #update" do
    put("/commodities/1").should route_to("commodities#update", :id => "1")
  end

  it "routes to #destroy" do
    delete("/commodities/1").should route_to("commodities#destroy", :id => "1")
  end  

  it "route through assertions" do
    assert_generates "/commodities/1", { :controller => "commodities", :action => "show", :id => "1" }
    assert_recognizes({ :controller => "commodities", :action => "show", :id => "1" }, { :path => "commodities/1", :method => :get })
    assert_routing({ :path => "commodities/1", :method => :get }, { :controller => "commodities", :action => "show", :id => "1" })
  end

end

describe "routing to sessions" do

  it "does not expose a list of sessions" do
    expect(:get => "/sessions").not_to be_routable
  end

  it "does not expose a list of sessions" do
    get("/sessions").should_not be_routable
  end

  it "routes to new session through login" do 
    expect(:get => "/login").to route_to(
      :controller => "sessions",
      :action => "new")
  end

  it "routes to create session through login" do 
    expect(:post => "/login").to route_to(
      :controller => "sessions",
      :action => "create")
  end
end

describe "routing to users" do

  it "routes to edit password for user with :id" do 
    expect(:get => "/users/1/edit_password").to route_to(
      :controller => "users",
      :action => "edit_password", 
      :id => "1")
  end

  it "routes to save password for user with :id" do
    expect(:put => "/users/1/save_password").to route_to(
      :controller => "users",
      :action => "save_password", 
      :id => "1")
  end
end


# Note 'route_for' has been depricated. Use route_to and be_routable

# CONTROLLER=users rake routes

# ActionDispatch::Assertions::RoutingAssertions
  # assert_generates, assert_recognizes, assert_routing
