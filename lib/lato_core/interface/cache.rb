module LatoCore
  module Interface
    # Insieme di funzioni che gestiscono la cache dei moduli sulla
    # applicazione principale.
    module Cache

      # Funzione che ritorna il percorso alla directory di cache usata dai
      # moduli lato per memorizzare informazioni sull'applicazione principale.
      # La directory dell'app principale usata come cache si trova nel percorso
      # #{Rails.root}/config/lato
      def core_getCacheDirectory
        # creo le directory per gli assets se non esistono
        dirname = "#{Rails.root}/app/assets/images/lato"
        FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
        dirname = "#{Rails.root}/app/assets/stylesheets/lato"
        FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
        dirname = "#{Rails.root}/app/assets/javascripts/lato"
        FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
        # creo la directory di cache se non esiste
        dirname = "#{Rails.root}/config/lato"
        FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
        # ritorno la directory di cache
        return dirname
      end

    end

  end
end
