module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Kiwi
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :customer, phone: 'to'
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
