module RedmineSSL
  module ApplicationControllerPatch

    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        before_filter :add_ssl_link_to_top_menu
      end
    end

    module InstanceMethods
      private
      def add_ssl_link_to_top_menu
        Redmine::MenuManager.map(:top_menu) do |map|
          html_options = {}
          
          if request.ssl?
            scheme = 'http://'
            html_options[:style] = 'text-decoration: line-through'
          else
            scheme = 'https://'
          end
          
          map.delete :ssl
          map.push :ssl, scheme + request.host_with_port + request.request_uri, :last => true, :caption => 'SSL', :html => html_options
        end
      end
    end
    
  end
end
