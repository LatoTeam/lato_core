# Lato Core

## Installation

Add the lato_core gem on your Gemfile

```ruby
gem 'lato_core'
```
Install the gem

```console
bundle install
```

Generate the initializer (Rails 5)

```console
rails lato_core_initialize
```

Generate the initializer (Rails 4)

```console
rake lato_core_initialize
```

Exec migrations

```console
bundle exec rake db:migrate
```

Now you can start the server and go to the relative url */lato/core*

You can access to the admin panel with these data:

* username: **lato**
* password: **password**

NB: You must install to work lato property **[lato_view](https://github.com/LatoTeam/lato_view)**

## Configuration (optional)

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
