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
gem 'lato_core', git: 'https://github.com/LatoTeam/lato_core.git'
```
Installare la gemma

```console
bundle install
```

Creare il file di configurazione

```console
rake lato_core_initialize
```

Eseguire le migrazioni

```console 
bundle exec rake db:migrate
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

Genera le directory per gli assets e la directory di cache nell'applicazione principale nel caso esse non esistano e ritorna il path della directory di cache.

#### Interface::Communication

Continene una serie di funzioni usate per ottenere informazioni sui vari moduli Lato usati nel progetto e per comunicare con loro.

* **core_getApplicationLoginRoot()**

Ritorna l'url relativo della directory a cui rimandare dopo aver effettuato il login in Lato. Se tale valore non è settato nel file di configurazione allora ritorna semplicemente false.

* **core_getApplicationURL()**

Legge il file di configurazione e verifica se e' stato impostato un root url per l'applicazione. Se non è stato impostato ritorna il valore di default 'localhost' altrimenti ritorna il valore settato.

* **core_getApplicationName()**

Ritorna il nome dell'applicazione principale settato nel file di configurazione. Se il file di configurazione non specifica nessun nome allora la funzione ritorna la stringa 'Lato'.

* **core_getApplicationServiceEmail()**

Ritorna l' indirizzo email di servizio della applicazione settato nel file di configurazione. Se non è stata impostata alcuna email allora utilizza quella di default 'service@lato.com'.

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

* **core_controlUser()**

Controlla che l'utente sia correttamente loggato. Nel caso contrario esegue un redirect alla pagina di login.

* **core_getCurrentUser()**

Ritorna un oggetto contenente l'utente loggato.

* **core_controlPermission(permission)**

Prende in input un numero intero compreso tra 1 e 10. Ritorna true se l'utente loggato ha i permessi maggiori o uguali al valore ricevuto come parametro, altrimenti ritorna false.

#### Interface::Languages

Insieme di funzioni utilizzate per gestire le possibili lingue dell'applicazione.

* **core_applicationHasLanguages()**

Controlla il file di configurazione di Lato per vedere se sono state impostate delle lingue. Se l'applicazione gestisce più di una lingua allora ritorna true, altrimenti false.

* **core_getApplicationLanguages()**

Ritorna un array contenente stringhe indicanti le lingue impostate nel file di configurazione per l'applicazione.
Se non sono state impostate lingue allora ritorna false.

* **core_loadModuleLanguages(module_name)**

Prende in input una stringa contenente il nome di un modulo Lato utilizzato dall'applicazione. Ritorna la lettura del file contenente tutte le stringhe usate dal modulo tradotte nella lingua principale dell'applicazione.

#### Inteface::Superusers

Insieme di funzioni usate per gestire gli utenti con accesso al pannello Lato.

* **core_notifyUser(user, title, message)**

Richiede come parametri un utente, un titolo e un messaggio e invia tale contenuto come notifica email all'utente.

* **core_getUsersPermissions()**

Ritorna la lista dei permessi che possono essere assegnati agli utenti amministratori sotto forma di array con la seguente struttura:

[[1,'nome_permesso'], [2,'nome_permesso']]

* **core_getHideUsersSettings()**

Legge il file di configurazione e, se è stato impostato per nascondere determinati utenti ad altri utenti, ritorna tali informazione attraverso un array con la seguente struttura:

[[1,4], [1,3]] => Nascondi utenti con permesso 1 ad utenti con permesso 4, nascondi utenti con permesso 1 ad utenti con permesso 3.

* **core_getHideUsersPermissionsSettings()**

Ritorna un array contenente i valori di permessi che non devono essere mostrati nel form di creazione/modifica utente.

* **core_getUsersPermissionsNamesSettings()**

Ritorna la traduzione dei valori di permessi utente impostata nel file di configurazione secondo la seguente struttura:

[[1,'nome_permesso'], [2,'nome_permesso']]
