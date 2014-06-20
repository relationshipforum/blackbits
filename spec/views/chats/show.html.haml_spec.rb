require 'rails_helper'

RSpec.describe "chats/show", :type => :view do
  before(:each) do
    @chat = assign(:chat, Chat.create!(
      :user_id => 1,
      :message => "Message"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Message/)
  end
end
