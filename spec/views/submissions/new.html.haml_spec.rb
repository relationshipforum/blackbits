require 'rails_helper'

RSpec.describe "submissions/new", :type => :view do
  before(:each) do
    assign(:submission, Submission.new(
      :title => "MyString",
      :body => "MyText",
      :author_id => 1,
      :forum_id => 1
    ))
  end

  it "renders new submission form" do
    render

    assert_select "form[action=?][method=?]", submissions_path, "post" do

      assert_select "input#submission_title[name=?]", "submission[title]"

      assert_select "textarea#submission_body[name=?]", "submission[body]"

      assert_select "input#submission_author_id[name=?]", "submission[author_id]"

      assert_select "input#submission_forum_id[name=?]", "submission[forum_id]"
    end
  end
end
