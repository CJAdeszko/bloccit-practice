require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) { Advertisement.create!(title: "New ad title", copy: "New ad copy", price: 200) }

  describe 'attributes' do
    it 'should have title, copy, and price attributes' do
      expect(advertisement).to have_attributes(title: "New ad title", copy: "New ad copy", price: 200)
    end
  end
end
