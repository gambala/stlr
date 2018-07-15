# frozen_string_literal: true

module WithReviews
  extend ActiveSupport::Concern

  included do
    has_many :reviews, as: :record, dependent: :destroy, inverse_of: :record
  end
end
