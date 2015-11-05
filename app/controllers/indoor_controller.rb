class IndoorController < ApplicationController
  respond_to :json, :js, :html
  skip_before_action :verify_authenticity_token

  @attuale = ''
  @record1 = 0
  @record2 = 0
  @record3 = 0
  @actualRecord = 0

  def index()
    readRecords
    @tabella =  creaTabella(32)
  end

  def readRecords
    a=Utente.where( user: Rails.application.config.my_config)[0]
    @attuale = a.user
    @record1 = a.record1
    @record2 = a.record2
    @record3 = a.record3
    @actualRecord = 0
  end

  def creaTabella(dimensione)
    @ris = '<table>'
    for i in (0..(dimensione+5))
      if i<=dimensione
        @ris = @ris + creaRiga(i,dimensione,'std')
      else
        @ris = @ris + creaRiga(i,dimensione,'h')
      end
    end
    @ris = @ris + '</table>'
    return @ris
  end

  def creaRiga(rigafissa,colonnetotali, t)
    @ris = '<tr>'
    for i in (0..(colonnetotali+5))
      id = rigafissa.to_s+"u"+i.to_s
      if i <= colonnetotali and t == 'std'
        @ris = @ris + "<td class= 'td' id='"+id+"'></td>"
      else
        @ris = @ris + "<td class= 'tdo' id='"+id+"'></td>"
      end
    end
    @ris = @ris + '</tr>'
    return @ris
  end

end