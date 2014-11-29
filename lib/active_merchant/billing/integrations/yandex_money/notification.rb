module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module YandexMoney
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def status
            params['notification_type']
          end

          def complete?
            status == 'p2p-incoming'
          end

          def item_id
            params['label']
          end

          def transaction_id
            params['operation_id']
          end

          def received_at
            params['datetime']
          end

          def currency
            params['currency']
          end

          def sender
            params['sender']
          end

          def codepro
            params['codepro']
          end

          def gross
            params['amount']
          end

          def amount
            BigDecimal.new(gross)
          end

          def sha1_hash
            params['sha1_hash']
          end

          def acknowledge(notification_secret)
            digest = Digest::SHA1.hexdigest([
              status,
              transaction_id,
              gross,
              currency,
              received_at,
              sender,
              codepro,
              notification_secret,
              item_id
            ].map(&:to_s).join('&'))

            sha1_hash == digest
          end
        end
      end
    end
  end
end
