module TenderSummary
  class Mailer < ActionMailer::Base
    self.template_root   = File.expand_path("#{File.dirname(__FILE__)}/templates")
    self.mailer_name     = 'mailer'
    self.delivery_method = :sendmail

    def pending(to, from = nil)
      discussions = TenderSummary::TenderApi.discussions(:state => :pending)

      from       from
      recipients to
      subject    "Tender pending discussions summary"
      body       :discussions => discussions['discussions'],
                 :site => TenderSummary::TenderApi.site,
                 :name => TenderSummary::TenderApi.site['name']
    end
  end
end