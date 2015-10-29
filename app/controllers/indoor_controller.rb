class IndoorController < ApplicationController

  def index
    createLabirinth
    setLabirinth(1)
    @repo = repository
    @tabella =  creaTabella(32)
  end

  def createLabirinth
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

  def repository
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

  def setLabirinth(livello)
    @lab = Labirinto.where(livello: livello)
    ##TODO PER OGNI ELEMENTO DI LAB CREA DINAMICAMENTE UN IDDEN RIGA CON TUTTE LE INFO
    ##variando incrementalmente l'id
    @livello = []
    @xstart = []
    @ystart = []
    @length = []
    @direction = []
    for i in (0..(@lab.size-1))
      @livello.push(@lab[i].livello)
      @xstart.push(@lab[i].xstart)
      @ystart.push(@lab[i].ystart)
      @length.push(@lab[i].length)
      @direction.push(@lab[i].direction)
    end
  end

  def creaTabella(dimensione)
    @ris = '<table style="width:60%" >'
    for i in (0..dimensione)
      @ris = @ris + creaRiga(i,dimensione)
    end
    @ris = @ris + '</table>'
    return @ris
  end

  def creaRiga(rigafissa,colonnetotali)
    @ris = '<tr>'
    for i in (0..colonnetotali)
      id = rigafissa.to_s+"-"+i.to_s
      @ris = @ris + "<td style='background-color: yellow;' id='"+id+"'> &nbsp </td>"
    end
    @ris = @ris + '</tr>'
    return @ris
  end

end
