class PostmortemController < ApplicationController
  def index
    @punteggio = params[:data]
    localRecords(@punteggio)
  end

  def localRecords(p)
    me=Utente.where( user: Rails.application.config.my_config)[0]
    @attuale = me.user
    records = [me.record1.to_i,me.record2.to_i,me.record3.to_i,p.to_i].sort
    @record1 = records.pop.to_s
    @record2 = records.pop.to_s
    @record3 = records.pop.to_s
    me.record1 = @record1
    me.record2 = @record2
    me.record3 = @record3
    me.save
  end

  def getBests(vettore)
    vettore.sort
  end

end
