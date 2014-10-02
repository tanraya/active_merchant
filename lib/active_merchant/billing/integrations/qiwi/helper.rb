module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Qiwi
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          def initialize(order, account, options = {})
            @to = options.delete(:to)
            super
          end

          def to
            @to.gsub(/\D/, '')
          end

          def form_fields
            @fields.merge(to: to)
          end

          mapping :account,     'from'
          mapping :amount,      'summ'
          mapping :order,       'txn_id'
          mapping :description, 'comm'
          mapping :currency,    'currency'

          def form_method
            'GET'
          end
        end
      end
    end
  end
end
