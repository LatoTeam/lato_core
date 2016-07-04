include LatoCore::Interface

# Insieme di variabili globali che mantengono dati altrimenti
# memorizzati in file yaml.
# Solitamente contengono la lettura del file di configurazione.
# Cambiare l'ordine in cui sono inserite potrebbe compromettere il corretto
# funzionamento del modulo.

# IMPOSTAZIONE LISTA ASSETS
# Contiene la lista degli assets custom lato
CORE_ASSETS = core_getAssetsItems

# IMPOSTAZIONE VOCI DI NAVIGAZIONE
# Contiene la lista di voci di navigazione di lato
CORE_NAVIGATION = core_getNavbarItems

# IMPOSTAZIONE NOME APPLICAZIONE
# Contiene il nome dell'applicazione
CORE_APPNAME = core_getApplicationName

# IMPOSTAZIONE URL APPLICAZIONE
# Cotiene l'url base del progetto
CORE_APPURL = core_getApplicationURL

# IMPOSTAZIONE ROOT PANNELLO GESTIONALE
# Contiene l'url della pagina di benvenuto custom
CORE_APPLOGINROOT = core_getApplicationLoginRoot

# IMPOSTAZIONE LOGO CUSTOM SVG PANNELLO
# Contiene il path del logo custom del pannello
CORE_APPLOGO = core_getApplicationLogo

# IMPOSTAZIONE LINGUE DELL'APPLICAZIONE

CORE_APPLANGUAGES = core_getApplicationLanguages

# IMPOSTAZIONE DATI SU UTENTI NASCOSTI

CORE_SUPERUSERSHIDESETTINGS = core_getHideUsersSettings

# IMPOSTAZIONE INDIRIZZO EMAIL DI SERVIZIO

CORE_APPSERVICEMAIL = core_getApplicationServiceEmail

# IMPOSTAZIONE PERMESSI UTENTE DA NASCONDERE ALL'UTENTE

CORE_SUPERUSERSPERMISSIONSHIDESETTINGS = core_getHideUsersPermissionsSettings

# IMPOSTAZIONE NOMI DEI PERMESSI UTENTE

CORE_SUPERUSERSPERMISSIONSNAMESSETTINGS = core_getUsersPermissionsNamesSettings

# IMPOSTAZIONE PERMESSI UTENTE

CORE_SUPERUSERSPERMISSIONS = core_getUsersPermissions
