class GeneralController < ApplicationController

  def index
    utenti = Utente.all
    utenti = utenti.sort_by { |h| h[:record1] }
    ut = utenti.pop
    @gr1name = ut.user
    @gr1res = ut.record1
    ut = utenti.pop
    @gr2name = ut.user
    @gr2res = ut.record1
    ut = utenti.pop
    @gr3name = ut.user
    @gr3res = ut.record1
  end

end
