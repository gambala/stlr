# frozen_string_literal: true

module Visitor
  extend ActiveSupport::Concern

  included do
    helper_method :visitor_id

    def visitor_id
      @visitor_id ||= cookies.encrypted[:visitor_id] ||= SecureRandom.uuid
    end
  end
end
