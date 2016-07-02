include LatoCore::Interface

# Insieme di variabili globali che mantengono dati altrimenti
# memorizzati in file yaml.
# Solitamente contengono la lettura del file di configurazione.
# Cambiare l'ordine in cui sono inserite potrebbe compromettere il corretto
# funzionamento del modulo.

# IMPOSTAZIONE LISTA ASSETS

CORE_ASSETS = core_getAssetsItems

# IMPOSTAZIONE VOCI DI NAVIGAZIONE

CORE_NAVIGATION = core_getNavbarItems

# IMPOSTAZIONE NOME APPLICAZIONE

CORE_APPNAME = core_getApplicationName

# IMPOSTAZIONE URL APPLICAZIONE

CORE_APPURL = core_getApplicationURL

# IMPOSTAZIONE ROOT PANNELLO GESTIONALE

CORE_APPLOGINROOT = core_getApplicationLoginRoot

# IMPOSTAZIONE LOGO CUSTOM SVG PANNELLO

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
