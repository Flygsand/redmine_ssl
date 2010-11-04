module RedmineSSL
  module MyControllerPatch

    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        before_filter :require_ssl_for_password_change, :only => :password
      end
    end

    module InstanceMethods
      private
      def require_ssl_for_password_change
        redirect_to 'https://' + request.host_with_port + request.request_uri unless request.ssl?
      end
    end
    
  end
end
