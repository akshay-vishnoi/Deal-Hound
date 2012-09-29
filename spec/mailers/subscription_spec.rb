require "spec_helper"

describe Subscription do
  describe "send_updates" do
    let(:mail) { Subscription.send_updates }

    it "renders the headers" do
      mail.subject.should eq("Send updates")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
