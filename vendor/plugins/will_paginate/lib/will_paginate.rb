require 'active_support'

# = You *will* paginate!
#
# First read about WillPaginate::Finder::ClassMethods, then see
# WillPaginate::ViewHelpers. The magical array you're handling in-between is
# WillPaginate::Collection.
#
# Happy paginating!
module WillPaginate
  class << self
    # shortcut for <tt>enable_actionpack; enable_activerecord</tt>
    def enable
      enable_actionpack
      enable_activerecord
    end

    # mixes in WillPaginate::ViewHelpers in ActionView::Base
    def enable_actionpack
      return if ActionView::Base.instance_methods.include? 'will_paginate'
      require 'will_paginate/view_helpers'
      ActionView::Base.class_eval { include ViewHelpers }

      if ActionController::Base.respond_to? :rescue_responses
        ActionController::Base.rescue_responses['WillPaginate::InvalidPage'] = :not_found
      end
    end

    # mixes in WillPaginate::Finder in ActiveRecord::Base and classes that deal
    # with associations
    def enable_activerecord
      return if ActiveRecord::Base.respond_to? :paginate
      require 'will_paginate/finder'
      ActiveRecord::Base.class_eval { include Finder }

      associations = ActiveRecord::Associations
      collection = associations::AssociationCollection

      # to support paginating finders on associations, we have to mix in the
      # method_missing magic from WillPaginate::Finder::ClassMethods to AssociationProxy
      # subclasses, but in a different way for Rails 1.2.x and 2.0
      (collection.instance_methods.include?(:create!) ?
        collection : collection.subclasses.map(&:constantize)
      ).push(associations::HasManyThroughAssociation).each do |klass|
        klass.class_eval do
          include Finder::ClassMethods
          alias_method_chain :method_missing, :paginate
        end
      end
    end
  end

  module Deprecation #:nodoc:
    extend ActiveSupport::Deprecation

    def self.warn(message, callstack = caller)
      message = 'WillPaginate: ' + message.strip.gsub(/ {3,}/, ' ')
      behavior.call(message, callstack) if behavior && !silenced?
    end

    def self.silenced?
      ActiveSupport::Deprecation.silenced?
    end
  end
end
