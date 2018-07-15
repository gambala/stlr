# frozen_string_literal: true

module InheritedFromModel
  extend ActiveSupport::Concern

  included do
    def self.model_name
      superclass.model_name
    end
  end
end
