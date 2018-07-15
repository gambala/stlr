# frozen_string_literal: true

module WithApprovedStatus
  extend ActiveSupport::Concern

  included do
    scope :approved, -> { where(approved: true) }

    def approve!
      self.approved = true
      check_approval! if save
    end

    def approved=(value)
      self.approved_at = Time.zone.now if approved == false && value.in?([true, 'true', '1', 1])
      super(value)
    end

    def approved_at
      super.presence || created_at
    end

    def check_approval!; end
  end
end
