class IndoorController < ApplicationController
  respond_to :json, :js, :html
  skip_before_action :verify_authenticity_token

  def index()
    a=Utente.where( user: Rails.application.config.my_config)[0]
    @attuale = a.user
    @record1 = a.record1
    @record2 = a.record2
    @record3 = a.record3
    @actualRecord = 0
    createLabirinth1
    createLabirinth2
    createLabirinth3
    createLabirinth4
    @tabella =  creaTabella(32)
  end

  def createLabirinth4
    createBarrier(13,4,0,0,30,1)
    createBarrier(14,4,4,0,30,1)
    createBarrier(15,4,8,0,30,1)
    createBarrier(16,4,12,0,30,1)
    createBarrier(17,4,16,0,30,1)
    createBarrier(18,4,2,2,30,1)
    createBarrier(19,4,6,2,30,1)
    createBarrier(20,4,14,2,30,1)
  end

  def createLabirinth3
    createBarrier(9,3,0,1,30,1)
    createBarrier(10,3,30,1,20,2)
    createBarrier(11,3,15,20,15,1)
    createBarrier(12,3,15,10,10,2)
  end

  def createLabirinth2
    createBarrier(5,2,0,1,30,2)
    createBarrier(6,2,8,1,30,2)
    createBarrier(7,2,16,1,30,2)
    createBarrier(8,2,24,1,30,2)
  end

  def createLabirinth1
    createBarrier(1,1,0,0,32,1)
    createBarrier(2,1,0,0,32,2)
    createBarrier(3,1,32,0,32,2)
    createBarrier(4,1,0,32,32,1)
  end

  def createBarrier(id,livello,xstart,ystart,length,direction)
    ids = Labirinto.where(id: id)
    if(ids.count==0)
      a = Labirinto.new
      a.id= id
      a.livello = livello
      a.xstart=xstart
      a.ystart=ystart
      a.length=length
      a.direction=direction
      a.save
    end
  end

=begin  def repository
     @repo = '<div hidden class="container" id="nascondi">'
     for i in (0..@lab.size-1)
        @repo = @repo + '<div class="row">'
        @repo = @repo + '<div class="col-sm-2" id="livello'+i.to_s+'">'+@livello[i]+'</div>'
        @repo = @repo + '<div class="col-sm-2" id="xstart'+i.to_s+'">'+@xstart[i]+'</div>'
        @repo = @repo + '<div class="col-sm-2" id="ystart'+i.to_s+'">'+@ystart[i]+'</div>'
        @repo = @repo + '<div class="col-sm-2" id="length'+i.to_s+'">'+@length[i]+'</div>'
        @repo = @repo + '<div class="col-sm-2" id="direction'+i.to_s+'">'+@direction[i]+'</div>'
        @repo = @repo + '</div>'
     end
     @repo = @repo + '<div id=barriers>' + @lab.size.to_s + '</div>'
     @repo = @repo + '</div>'
  end
=end

  def creaTabella(dimensione)
    @ris = '<table>'
    for i in (0..dimensione)
      @ris = @ris + creaRiga(i,dimensione)
    end
    @ris = @ris + '</table>'
    return @ris
  end

  def creaRiga(rigafissa,colonnetotali)
    @ris = '<tr>'
    for i in (0..(colonnetotali+5))
      id = rigafissa.to_s+"-"+i.to_s
      if i <= colonnetotali
        @ris = @ris + "<td class= 'td' id='"+id+"'></td>"
      else
        @ris = @ris + "<td class= 'tdo' id='"+id+"'></td>"
      end
    end
    @ris = @ris + '</tr>'
    return @ris
  end

end