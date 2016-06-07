# Lato Core

**Lato** è un progetto italiano di software modulare sviluppato in Ruby on Rails.
Il modulo **lato_core** è in grado di offrire diverse funzionalità tra le quali:

* Gestione accessi al pannello di amminisrazione del software
* Gestione utenti con permessi di accesso al pannello di amministrazione
* Funzioni per la gestione delle sessioni degli utenti
* Funzioni per la comunicazione con altri moduli
* Funzioni per la generazione dei dati di navigazione tra le pagine dei moduli
* Funzioni per la gestione dell'autenticazione degli utenti
* Funzioni per la gestione dei permessi degli utenti

## Installazione

Aggiungere la gemma alla vostra applicazione

```ruby
gem 'lato_core'
```
Installare la gemma ed eseguire le migrazioni

```console
bundle install
bundle exec rake db:migrate
```

Creare il file di configurazione

```console
rake lato_core_initialize
```

Avviare il server e accedere al pannello di amministrazione attraverso la pagina */lato/core*

I dati di accesso iniziali al pannello sono:

* username: **lato**
* password: **password**

NB: Per il corretto funzionamento del modulo è necessario installare manualmente anche la gemma **[lato_view](https://github.com/LatoTeam/lato_view)**

## Configurazione (opzionale)

La configurazione di Lato Core può essere eseguita modificando il file di configurazione presente in /config/lato/config.yml

## Sviluppare con Lato Core

Per sviluppare utilizzando le funzioni messe a disposizione da Lato è possibile consultare la documentazione di ogni singolo modulo.
