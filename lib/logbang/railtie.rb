module Logbang
  class Railtie < Rails::Railtie
    initializer "logbang.configure_rails_initialization" do
      ActionController::Base.send(:include, Logbang::Helper)
    end

    # Writes the log string out to the Rails logger in a pretty yellow
    # colour that is almost impossible to miss!
    def self.log(message)
      out = ""
      out << ActiveSupport::LogSubscriber::YELLOW
      out << ActiveSupport::LogSubscriber::BOLD
      out << " = "
      out << message
      out << ActiveSupport::LogSubscriber::CLEAR
      Rails.logger.info out
    end
  end
end

