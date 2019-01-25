require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { Question.create!(title: "Question title", body: "Question body", resolved: true) }
  let(:answer) { Answer.create!(body: "Answer body", question: question) }

  describe 'attributes' do
    it 'has a body attribute' do
      expect(answer).to have_attributes(body: "Answer body")
    end
  end
end
