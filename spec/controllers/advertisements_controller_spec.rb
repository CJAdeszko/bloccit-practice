require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let(:my_ad) { Advertisement.create!(title: "New ad title", copy: "New ad copy", price: 200) }


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns my_ad to @advertisements' do
      get :index
      expect(assigns(:advertisements)).to eq([my_ad])
    end
  end


  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: my_ad.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      get :show, params: { id: my_ad.id }
      expect(response).to render_template(:show)
    end

    it 'assigns my_ad to @ad' do
      get :show, params: { id: my_ad.id }
      expect(assigns(:ad)).to eq(my_ad)
    end
  end


  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'instantiates @ad' do
      get :new
      expect(assigns(:ad)).not_to be_nil
    end
  end


  describe "POST #create" do
    it "increases the number of Advertisement by 1" do
      expect { post :create, params: { advertisement: { title: "New ad title", copy: "New ad copy", price: 200 } } }.to change(Advertisement, :count).by(1)
    end

    it 'assigns the new ad to @ad' do
      post :create, params: { advertisement: {title: "New ad title", copy: "New ad copy", price: 200 } }
      expect(assigns(:ad)).to eq(Advertisement.last)
    end

    it 'redirects to the new ad' do
      post :create, params: { advertisement: {title: "New ad title", copy: "New ad copy", price: 200 } }
      expect(response).to redirect_to(Advertisement.last)
    end
  end

end
