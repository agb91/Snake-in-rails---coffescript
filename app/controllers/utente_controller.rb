class UtenteController < ApplicationController
  def new
    @ut = Utente.new
  end

  def create
    #render plain: params[:utente]
    @ut = Utente.new(ad_params)
    @ut.save
    redirect_to '/home/index'
  end

  private
  def ad_params
    params.require(:utente).permit(:user, :password)
  end
end
