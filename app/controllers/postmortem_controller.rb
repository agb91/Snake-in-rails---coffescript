class PostmortemController < ApplicationController
  def index
    @punteggio = params[:data]
    @attuale = me.user
    localRecords
    generalRecords
  end

  def generalRecords
TODO: RIPENSA MODEL RANKING: MEGLIO USARE OGGETTO 'USER'
  end

  def localRecords
    me=Utente.where( user: Rails.application.config.my_config)[0]
    records = getBests([me.record1,me.record2,me.record3,@punteggio])
    @record1 = records.pop
    @record2 = records.pop
    @record3 = records.pop
    me.record1 = @record1
    me.record2 = @record2
    me.record3 = @record3
    me.save
  end

  def getBests(vettore)
    vettore.sort
  end

end
