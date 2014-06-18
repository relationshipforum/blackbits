require 'rails_helper'

RSpec.describe "submissions/show", :type => :view do
  before(:each) do
    @submission = assign(:submission, Submission.create!(
      :title => "Title",
      :body => "MyText",
      :author_id => 1,
      :forum_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
