class PostmortemController < ApplicationController
  def index
    @punteggio = params[:data]
    a=Utente.where( user: Rails.application.config.my_config)[0]
    @attuale = a.user
    records = getBests([a.record1,a.record2,a.record3,@punteggio])
    @record1 = records.pop
    @record2 = records.pop
    @record3 = records.pop
    a.record1 = @record1
    a.record2 = @record2
    a.record3 = @record3
    a.save
  end

  def getBests(vettore)
    vettore.sort
  end

end
