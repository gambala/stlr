# frozen_string_literal: true

module WithMoneyPayments
  extend ActiveSupport::Concern

  included do
    has_many :money_payments, as: :record, dependent: :destroy, inverse_of: :record

    def check_payments!; end

    def total
      @total ||= money_payments.approved.sum(:total)
    end
  end
end
