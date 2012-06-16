require 'acceptance/acceptance_helper'

describe 'questions', :type => :request do
  before do
    @camp = Camp.current || Camp.make!
    @user = @camp.users.make!
    sign_in_as(@user)
  end

  it "lets somebody post a question" do
    visit questions_path

    click_link "Add a Question"

    fill_in "Question", with: "When is the walk and where do we meet?"
    fill_in "Details", with: "The thing says nothing about where we're meeting. WHATS GOING ON"

    click_button "Create Question"

    question = Question.first
    question.title.should == "When is the walk and where do we meet?"
    question.description.should == "The thing says nothing about where we're meeting. WHATS GOING ON"
    question.user.should == @user

    current_path.should == question_path(question)
  end

  it "shows all the questions" do
    question = Question.create(title: "Here is something I would like to know", description: "These are some details.")
    visit questions_path

    page.should have_content(question.title)
    page.should have_content(question.description)
  end

  it "lets somebody comment on a question"
  it "lets somebody upvote a question"
end