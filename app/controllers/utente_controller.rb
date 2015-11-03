class UtenteController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @ut = Utente.new
  end

  def create
    #render plain: params[:utente]
    @ut = Utente.new(ad_params)
    if(Utente.where(user: @ut.user).length==0)
      @ut.save
    end
    redirect_to '/home/index'
  end

  private
  def ad_params
    params.require(:utente).permit(:user, :password)
  end
end
