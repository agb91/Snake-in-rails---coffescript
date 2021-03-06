class LoginController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def read
    Rails.application.config.my_config = ad_params[:user]
    ##render plain: ad_params
    if check(ad_params[:user],ad_params[:password])
      redirect_to '/indoor/index'
    else
      redirect_to '/outdoor/index'
    end
  end

  def check(user, pass)
    @ris = false
    @users = Utente.all
    @users.each do |x|
      if x[:user]==user
        if x[:password]==pass
          @ris = true
        end
      end
    end
    return @ris
  end

  private
  def ad_params
    params.require(:utente).permit(:user, :password)
  end
end
