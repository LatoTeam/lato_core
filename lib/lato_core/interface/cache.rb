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
        dirname = "#{Rails.root}/config/lato"
        FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
        dirname
      end

    end

  end
end
