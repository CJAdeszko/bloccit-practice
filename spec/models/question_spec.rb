require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "Question title", body: "Question body", resolved: true) }

  describe 'attributes' do
    it 'has title, body, and resolved attributes' do
      expect(question).to have_attributes(title: "Question title", body: "Question body", resolved: true)
    end
  end
end
