class GeneralController < ApplicationController

  def index
    @grnames = []
    @grres = []
    utenti = utentiOrdinati
    setInForm(utenti)
  end

  def utentiOrdinati
    utenti = Utente.all
    utenti = utenti.sort_by { |h| h[:record1]}
  end

  def setInForm(utenti)
    tot = utenti.length
    for i in (0..2)
      setUtente(utenti[(tot-i-1)],i)
    end
  end

  def setUtente(utente, numero)
    @grnames[numero] = utente.user
    @grres[numero] = utente.record1
  end

end
