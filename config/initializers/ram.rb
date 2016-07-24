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
# Contiene l'indirizzo email usato cdi default come mittente del mailer
CORE_APPSERVICEMAIL = core_getApplicationServiceEmail

# IMPOSTAZIONE DATI SU UTENTI NASCOSTI
# Contiene la lista di permessi utente che rappresentano gli utenti da non
# mostrare nella pagina users.
CORE_SUPERUSERSHIDESETTINGS = core_getHideUsersSettings

# IMPOSTAZIONE PERMESSI UTENTE DA NASCONDERE ALL'UTENTE
# Contiene la lista di permessi utente da non mostrare nel form di creazione/modifica
# utenti
CORE_SUPERUSERSPERMISSIONSHIDESETTINGS = core_getHideUsersPermissionsSettings

# IMPOSTAZIONE NOMI DEI PERMESSI UTENTE
# Contiene la lista di traduzioni da numero permesso utente a valore testuale
CORE_SUPERUSERSPERMISSIONSNAMESSETTINGS = core_getUsersPermissionsNamesSettings

# IMPOSTAZIONI VISUALIZZAZIONE SEZIONE RECUPERO PASSWORD
# Contiene un valore booleano indicante se e' possibile o meno utilizzare il
# recupero password per gli utenti
CORE_RECOVERYPASSWORDPERMISSION = core_getRecoveryPasswordPermission
