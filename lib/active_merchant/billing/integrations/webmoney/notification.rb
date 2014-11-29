module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Webmoney
        class Notification < ActiveMerchant::Billing::Integrations::Notification

          def amount
            BigDecimal.new(gross)
          end

          def item_id
            params['LMI_PAYMENT_NO']
          end

          def gross
            params['LMI_PAYMENT_AMOUNT']
          end

          def security_key
            params["LMI_HASH"]
          end

          def acknowledge(notification_secret)
            digest = Digest::MD5.hexdigest([
              params['LMI_PAYEE_PURSE'],
              gross,
              item_id,
              params['LMI_MODE'],
              params['LMI_SYS_INVS_NO'],
              params['LMI_SYS_TRANS_NO'],
              params['LMI_SYS_TRANS_DATE'],
              notification_secret,
              params['LMI_PAYER_PURSE'],
              params['LMI_PAYER_WM']
            ].join.upcase)

            security_key == digest
          end
        end
      end
    end
  end
end
