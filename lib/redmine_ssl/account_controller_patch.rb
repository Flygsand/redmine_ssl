module RedmineSSL
  module AccountControllerPatch

    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        before_filter :require_ssl_for_login_and_registration, :only => [:login, :register]
      end
    end

    module InstanceMethods
      private
      def require_ssl_for_login_and_registration
        redirect_to 'https://' + request.host_with_port + request.request_uri unless request.ssl?
      end
    end
    
  end
end
