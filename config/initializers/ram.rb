include LatoCore::Interface

# Insieme di variabili globali che mantengono dati altrimenti
# memorizzati in file yaml.
# Solitamente contengono la lettura del file di configurazione.
# Cambiare l'ordine in cui sono inserite potrebbe compromettere il corretto
# funzionamento del modulo.

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

# IMPOSTAZIONE LINGUE DELL'APPLICAZIONE
# Continene la lista delle lingue dell'applicazione gestita con lato
CORE_APPLANGUAGES = core_getApplicationLanguages

# IMPOSTAZIONE INDIRIZZO EMAIL DI SERVIZIO

CORE_APPSERVICEMAIL = core_getApplicationServiceEmail

# IMPOSTAZIONE DATI SU UTENTI NASCOSTI

CORE_SUPERUSERSHIDESETTINGS = core_getHideUsersSettings

# IMPOSTAZIONE PERMESSI UTENTE DA NASCONDERE ALL'UTENTE

CORE_SUPERUSERSPERMISSIONSHIDESETTINGS = core_getHideUsersPermissionsSettings

# IMPOSTAZIONE NOMI DEI PERMESSI UTENTE

CORE_SUPERUSERSPERMISSIONSNAMESSETTINGS = core_getUsersPermissionsNamesSettings

# IMPOSTAZIONE PERMESSI UTENTE

CORE_SUPERUSERSPERMISSIONS = core_getUsersPermissions
