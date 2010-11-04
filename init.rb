# -*- coding: utf-8 -*-

require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :redmine_ssl do
  app_dependency = Redmine::VERSION.to_a.slice(0,3).join('.') > '0.8.4' ? 'application_controller' : 'application'
  require_dependency(app_dependency)
  unless ApplicationController.included_modules.include?(RedmineSSL::ApplicationControllerPatch)
    ApplicationController.send(:include, RedmineSSL::ApplicationControllerPatch)
  end

  require_dependency 'account_controller'
  unless AccountController.included_modules.include?(RedmineSSL::AccountControllerPatch)
    AccountController.send(:include, RedmineSSL::AccountControllerPatch)
  end

  require_dependency 'my_controller'
  unless MyController.included_modules.include?(RedmineSSL::MyControllerPatch)
    MyController.send(:include, RedmineSSL::MyControllerPatch)
  end
end

Redmine::Plugin.register :redmine_ssl do
  name 'Redmine SSL'
  author 'Martin Häger'
  description 'SSL integration for Redmine'
  version '0.0.1'
  
  author_url 'http://freeasinbeard.org'
end


