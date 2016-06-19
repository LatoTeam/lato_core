# Lato Core

**Lato** è un progetto italiano di software modulare sviluppato in Ruby on Rails.

Ogni modulo lato è strutturato in modo tale da avere:

* Una interfaccia grafica che utilizza gli helper forniti da lato_view completamente integrata con gli altri moduli e protetta dall'autenticazione.
* Una serie di api per la comunicazione con altri sistemi tramite webservices
* Una serie di funzioni pubbliche utilizzabili dall'applicazione principale o da altri moduli dipendenti (**Interface**)

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

La configurazione di lato_core può essere eseguita modificando il file di configurazione presente in /config/lato/config.yml.

All'interno del file sono presenti una serie di impostazioni che possono essere personalizzate per adattare il pannello di amministrazione alla applicazione che si vuole sviluppare.

## Sviluppare con Lato Core

Per sviluppare utilizzando le funzioni messe a disposizione da Lato è possibile consultare la documentazione di ogni singolo modulo.3

### Aggiungere un custom controller al pannello Lato

Durante lo sviluppo di una applicazione può essere necessario integrare delle sezioni customizzate al pannello di amministrazione di Lato.

Per integrare le view di un controller al pannello di Lato basta impostare il layout di lato_view e controllare l'autenticazione dell'utente.

```ruby
class CustomController < ApplicationController

  layout 'lato_layout'
  before_action :core_controlUser

end
```

### Aggiungere una voce di menu al pannello di Lato

La sidebar di Lato si compone in modo automatico con le voci di menu dei moduli utilizzati nel progetto. Le voci di menu sono visibili agli utenti con permessi minimi di livello 5 (in una scala da 1 a 10).

Per aggiungere una voce di menu al pannello basta modificare il file di configurazione in /config/lato/config.yml.

Un esempio di file di configurazione che aggiunge una voce al menu è il seguente:

```yaml
menu:
  example:
    name: Prodotti
    url: "/admin/products"
    icon: arrow-right
    position: 1
    permission: 0
```

### Modificare il logo del pannello di Lato

Il logo standard del pannello di Lato può essere sostituito semplicemente inserendo nella directory /config/lato/ un file svg chiamato 'logo.svg'.

### Funzione d'interfaccia di Lato Core

Le funzioni di interfaccia sono una serie di funzioni messe a disposizione dal modulo per essere utilizzate durante lo sviluppo dell'applicazione o di nuovi moduli.

Per includere le funzioni in un file .rb del progetto basta aggiungere il seguente codice:

```ruby
include LatoCore::Interface
```
#### Interface::Cache

Contiene una serie di funzioni usate per gestire una directory di cache all'interno dell'applicazione che utilizza Lato.

Tale directory può essere utilizzata per memorizzare files di configurazione o altri dati utili.

* **core_getCacheDirectory()**

Genera la directory di cache nell'applicazione principale nel caso essa non esista e ritorna il path di tale directory

#### Interface::Communication

Continene una serie di funzioni usate per ottenere informazioni sui vari moduli Lato usati nel progetto e per comunicare con loro.

* **core_getApplicationLoginRoot()**

Ritorna l'url relativo della directory a cui rimandare dopo aver effettuato il login in Lato. Se tale valore non è settato nel file di configurazione allora ritorna semplicemente false.

* **core_getApplicationLogo()**

Ritorna l'url del logo custom da applicare alla applicazione Lato. Se non è stato caricato alcun logo allora ritorna false.

* **core_getApplicationName()**

Ritorna il nome dell'applicazione principale settato nel file di configurazione. Se il file di configurazione non specifica nessun nome allora la funzione ritorna la stringa 'Lato'.

* **core_getLatoGems()**

Esamina tutte le gemme usate dalla applicazione principale e ritorna solamente quelle appartenenti al progetto Lato sotto forma di array di stringhe.

* **core_getGems()**

Ritorna la lista dei nomi delle gemme utilizzate dalla applicazione principale sotto forma di array.

#### Interface::Session

Insieme di funzioni utilizzabili per gestire le sessioni delle utenze di Lato.

* **core_createSession(username, password)**

Prende in input le stringhe contenenti l'username e la password di un utente.
Se i dati dell'utente risultano corretti allora esegue crea una sessione per l'utente e ritorna true; in caso contrario ritorna false.

#### Interface::Navigation

Insieme di funzioni che gestiscono la sidebar di navigazione del pannello Lato.

* **core_getNavbarItems()**

Ritorna un array di hash contenenti le informazioni delle voci della sidebar.

#### Interface::Assets

Insieme di funzioni utilizzate per gestire gli assets che definiscono lo stile e il corretto funzionamento del pannello di Lato.

* **core_getAssetsItems()**

Ritorna un array contenente gli url relativi degli assets da usare per costruire il layout di Lato.

#### Interface::Authentication

Insieme di funzioni utilizzate per la gestione delle autenticazioni degli utenti.

**Coming Soon**
