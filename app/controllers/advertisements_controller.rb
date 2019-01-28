class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def show
    @ad = Advertisement.find(params[:id])
  end

  def new
    @ad = Advertisement.new
  end

  def create
    @ad = Advertisement.new
    @ad.title = params[:advertisement][:title]
    @ad.copy = params[:advertisement][:copy]
    @ad.price = params[:advertisement][:price]

    if @ad.save
      flash[:notice] = "Advertisement saved successfully"
      redirect_to @ad
    else
      flash.now[:alert] = "There was an error saving the advertisement. Please try again."
      render :new
    end
  end
end
