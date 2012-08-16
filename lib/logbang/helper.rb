require 'active_support/concern'

module Logbang
  # Adds the +log!+ functionality to the Rails ActionController::Base
  # method, and sets up an after_filter to dump the timing statistics at
  # the end of each request.
  module Helper
    extend ActiveSupport::Concern

    included do
      helper_method :log!
      after_filter  :dump_log!
    end

    # Create a log entry with timing data and a unique ID.
    #
    # This will show as a yellow log entry like :
    #    = Marked: container-start - 6d5c4c5
    #
    # If +message+ is left blank, the caller filename will be used.
    def log!(message=nil)
      call_list = caller.find_all { |x| x =~ /#{Rails.root}/ }
      mycaller = call_list[0].to_s.gsub(/^([^:]+):.*/, '\1')

      message = mycaller.gsub(/#{Rails.root}/,'') if message.nil?

      call_list.reject! { |x| x =~ Regexp.new("^#{mycaller}") }
      parent   = call_list[0].to_s.gsub(/^([^:]+):.*/, '\1') if call_list[0]

      @log_markers ||= []
      time = Time.now.to_f
      id   = Digest::MD5.hexdigest("#{message}#{time}")
      @log_markers << { :time   => time,
                        :caller => mycaller,
                        :parent => parent,
                        :marker => message,
                        :id     => id
                      }
      Logbang::Railtie.log "Marked: #{message} - #{id[0..6]}"
    end

  private

    # Dumps out the logs and timing data at the end of the request, like:
    #
    #   = 56e83ce @     0ms (+    0ms)  /app/views/agreements/index.html.erb
    #   = 8933225 @   391ms (+  391ms)    helper-start
    #   = 8dc03cc @   444ms (+   53ms)    helper-end
    #   = 4380ee5 @   625ms (+  180ms)  container-start
    #   = bcec099 @   694ms (+   69ms)  container-end
    def dump_log!
      return nil if @log_markers.blank?
      known_markers = {}
      first = nil
      last  = nil
      @log_markers.each do |marker|
        first = marker[:time] if first.blank?
        last  = first if last.nil?
        idx = known_markers[marker[:caller]]
        if idx.nil? then
          idx = known_markers[marker[:parent]]
          if idx.nil? then
            idx = 0
          else
            idx += 1
          end
          known_markers[marker[:caller]] = idx
        end

        duration = ((marker[:time] - last)  * 1000).to_i
        total    = ((marker[:time] - first) * 1000).to_i

        message = "#{marker[:id][0..6]} @ #{sprintf('% 5d',total)}ms (+#{sprintf('% 5d', duration)}ms) #{"  " * idx} #{marker[:marker]}"
        Logbang::Railtie.log message
        last = marker[:time]
        true
      end
    end
  end
end
