class ProvidersController < ApplicationController
  def index
  end
  
  def new
    @provider = Provider.new
  end
  
  def create
    @provider = Provider.new(params[:provider])
     if @provider.save
       						flash[:notice] = "Submission Successful"
       					else
       						flash[:notice] = "Hey there! looks like there was an error with your entry, please fill in all required fields."
       					end
       					render "new"
  end
  
  def edit
  end
  
  def update
  end
  
  def show
     @provider = Provider.find(params[:id])
     @json = Provider.find(params[:id]).to_gmaps4rails
  end
  
  def destroy
  end
  
  def vote
    value = params[:type] == "up" ? 1 : -1
      @provider = Provider.find(params[:id])
      @provider.add_or_update_evaluation(:votes, value, current_user)
      redirect_to :back, notice: "Thanks for voting!"
  end
end
