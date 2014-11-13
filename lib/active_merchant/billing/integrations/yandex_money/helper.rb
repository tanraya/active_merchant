module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module YandexMoney
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          def initialize(order, account, options = {})
            #@notification_secret = options.delete(:'notification_secret')

            formcomment   = options.delete(:'formcomment')
            quickpay_form = options.delete(:'quickpay-form') { |key| "shop" }
            short_dest    = options.delete(:'short-dest') { |key| formcomment }
            payment_type  = options.delete(:'paymentType') { |key| "PC" }
            targets       = options.delete(:'targets') { |key| "Заказ №0" }

            super

            add_field('quickpay-form', quickpay_form)
            add_field('formcomment', formcomment)
            add_field('short-dest', short_dest)
            add_field('paymentType', payment_type)
            add_field('targets', targets)
          end

          #def notification_secret
          #  @notification_secret
          #end

          mapping :account,     'receiver'
          mapping :amount,      'sum'
          mapping :order,       'label'
          mapping :description, 'targets'
        end
      end
    end
  end
end
