require 'rails_helper'

RSpec.describe "chats/new", :type => :view do
  before(:each) do
    assign(:chat, Chat.new(
      :user_id => 1,
      :message => "MyString"
    ))
  end

  it "renders new chat form" do
    render

    assert_select "form[action=?][method=?]", chats_path, "post" do

      assert_select "input#chat_user_id[name=?]", "chat[user_id]"

      assert_select "input#chat_message[name=?]", "chat[message]"
    end
  end
end
