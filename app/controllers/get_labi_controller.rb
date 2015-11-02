class GetLabiController < ApplicationController
  def index
    @labi = Labirinto.all
  end
end
