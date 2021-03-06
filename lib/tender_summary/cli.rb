
module TenderSummary
  class Cli
    attr_accessor :to, :from, :output

    def initialize(argv)
      @argv = argv.dup
    end

    def run
      self.parse

      if output.present?
        mail = TenderSummary::Mailer.create_pending(self.to, self.from)
        open(output, 'w') do |io|
          io << mail.parts.first.body
        end
      else
        TenderSummary::Mailer.deliver_pending(self.to, self.from)
      end
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

        opts.on("-f", "--from FROM", "Email address to use for From") do |n|
          self.from = n
        end

        opts.on("-o", "--output FILE", "Output HTML to file instead of sending") do |n|
          self.output = n
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
