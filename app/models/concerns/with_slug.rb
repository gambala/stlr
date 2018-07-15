# frozen_string_literal: true

module WithSlug
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :id, use: %i(slugged history finders)
    validates :slug, uniqueness: { case_sensitive: false },
                     format: { with: /\A[a-z\-\d]+\z/ },
                     allow_blank: true
  end
end
