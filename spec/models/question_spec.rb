require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false) }

  describe 'attributes' do
    it 'has title, body, and resolved attributes' do
      expect(question).to have_attributes(title: question.title, body: question.body, resolved: question.resolved)
    end
  end
end
