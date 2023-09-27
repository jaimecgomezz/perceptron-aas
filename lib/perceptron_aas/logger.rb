module PerceptronAas
  module Logger
    LOG_LEVEL = (ENV['LOG_LEVEL'] || 1).to_i

    if LOG_LEVEL >= 5
      def lens(msg, now = nil)
        log(" LENS: #{msg}")
      end
    else
      def lens(_); end
    end

    if LOG_LEVEL >= 4
      def trace(msg)
        log("TRACE: #{msg}")
      end
    else
      def trace(_); end
    end

    if LOG_LEVEL >= 3
      def debug(msg)
        log("DEBUG: #{msg}")
      end
    else
      def debug(_); end
    end

    if LOG_LEVEL >= 2
      def info(msg)
        log(" INFO: #{msg}")
      end
    else
      def info(_); end
    end

    if LOG_LEVEL >= 1
      def warn(msg)
        log("WARN: #{msg}")
      end
    else
      def warn(_); end
    end

    def err!(msg)
      log("ERROR: #{msg}")
      exit(1)
    end

    def log(msg)
      puts("[#{Time.now.iso8601(0)}] #{msg}")
    end
  end
end
