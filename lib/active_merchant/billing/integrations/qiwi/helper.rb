require 'uri'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Qiwi
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          def initialize(order, account, options = {})
            to         = options.delete(:to)
            successUrl = options.delete(:successUrl)
            failUrl    = options.delete(:failUrl)

            super

            add_field('to', to.to_s.gsub(/\D+/, ''))
            add_field('successUrl', URI::escape(successUrl)) if successUrl
            add_field('failUrl', URI::escape(failUrl)) if failUrl
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
