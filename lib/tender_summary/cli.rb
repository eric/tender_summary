
module TenderSummary
  class Cli
    attr_accessor :to

    def initialize(argv)
      @argv = argv.dup
    end

    def run
      self.parse

      TenderSummary::Mailer.deliver_pending(self.to)
    end

    def parse
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename($0)} [options]"

        opts.separator ' '
        opts.separator 'Specific options:'

        opts.on("-s", "--subdomain SUBDOMAIN", "Tender subdomain") do |n|
          TenderSummary::TenderApi.subdomain = n
        end

        opts.on("-u", "--username USERNAME", "Tender username") do |n|
          TenderSummary::TenderApi.username = n
        end

        opts.on("-p", "--password PASSWORD", "Tender password") do |n|
          TenderSummary::TenderApi.password = n
        end

        opts.on("-t", "--to a,b,c", Array, "Users to email") do |n|
          self.to = n
        end

        opts.separator " "
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end

      opts.parse!(@argv)

      TenderSummary::TenderApi.authenticate
    end
  end
end
