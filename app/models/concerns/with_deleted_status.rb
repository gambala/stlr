# frozen_string_literal: true

module WithDeletedStatus
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(deleted: false) }
    scope :deleted, -> { where(deleted: true) }

    def active?
      deleted == false
    end

    def deleted?
      deleted == true
    end

    def delete!
      self.deleted = true
      check_deletion! if save
    end

    def deleted=(value)
      self.deleted_at = Time.zone.now if deleted == false && value.in?([true, 'true', '1', 1])
      super(value)
    end

    def deleted_at
      super.presence || updated_at
    end

    def check_deletion!; end
  end
end
