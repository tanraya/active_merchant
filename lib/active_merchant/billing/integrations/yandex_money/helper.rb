module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module YandexMoney
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          def initialize(order, account, options = {})
            @notification_secret = options.delete('notification_secret'.to_sym)

            formcomment   = options.delete('formcomment'.to_sym)
            quickpay_form = options.delete('quickpay-form'.to_sym) { |key| "shop" }
            short_dest    = options.delete('short-dest'.to_sym) { |key| formcomment }
            payment_type  = options.delete('paymentType'.to_sym) { |key| "PC" }
            targets       = options.delete('targets'.to_sym) { |key| "Заказ №0" }

            super

            add_field('quickpay-form', quickpay_form)
            add_field('formcomment', formcomment)
            add_field('short-dest', short_dest)
            add_field('paymentType', payment_type)
            add_field('targets', targets)
            targets
          end

          def notification_secret
            @notification_secret
          end

          mapping :account,     'receiver'
          mapping :amount,      'sum'
          mapping :order,       'label'
          mapping :description, 'targets'
        end
      end
    end
  end
end
