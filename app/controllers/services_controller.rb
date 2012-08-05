class ServicesController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  
  def index
    @services = Service.search(params[:search])
  end
  
  def new
    @service = Service.new
  end
  
  def create
    @service = Service.new(params[:service])
    @service.save
    redirect_to root_path
  end
  
  def edit
    @service = Service.find(params[:id])
  end
  
  def update
    @service = Service.find(params[:id])
    @service.update_attributes(params[:service])
    redirect_to root_path
  end
  
  def show
      @service = Service.find(params[:id])
      @providers = @service.providers.find_with_reputation(:votes, :all, order: "votes desc")
      @json = @service.providers.all.to_gmaps4rails
      
      if params[:search].present?
          @providers = @service.providers.near(params[:search], 50, :order => :distance)
          @json = @service.providers.near(params[:search], 50, :order => :distance).to_gmaps4rails
      end
  end
  
  def destroy
  end
  
end
