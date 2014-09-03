require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Kiwi
        # Полезно смотреть тут: https://github.com/Shopify/active_merchant/commit/646919b4016ba75095acb69a029493d1075272ce
        # https://static.qiwi.com/ru/doc/ishop/protocols/Visa_QIWI_Wallet_Pull_Payments_API.pdf
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            status == 'paid'
          end

          def item_id
            params['']
          end

          def transaction_id
            params['bill_id']
          end

          def amount
            BigDecimal.new(gross)
          end

          # When was this payment received by the client.
          #def received_at
          #  params['']
          #end

          #def payer_email
          #  params['']
          #end

          def receiver
            params['user']
          end

          def security_key
            params['']
          end

          # the money amount we received in X.2 decimal.
          def gross
            params['amount']
          end

          # Was this a test transaction?
          def test?
            false
          end

          def status
            params['status']
          end

          # Acknowledge the transaction to Kiwi. This method has to be called after a new
          # apc arrives. Kiwi will verify that all the information we received are correct and will return a
          # ok or a fail.
          #
          # Example:
          #
          #   def ipn
          #     notify = KiwiNotification.new(request.raw_post)
          #
          #     if notify.acknowledge
          #       ... process order ... if notify.complete?
          #     else
          #       ... log possible hacking attempt ...
          #     end
          def acknowledge(authcode = nil)
            payload = raw

            uri = URI.parse(Kiwi.notification_confirmation_url)

            request = Net::HTTP::Post.new(uri.path)

            request['Content-Length'] = "#{payload.size}"
            request['User-Agent'] = "Active Merchant -- http://activemerchant.org/"
            request['Content-Type'] = "application/x-www-form-urlencoded"

            http = Net::HTTP.new(uri.host, uri.port)
            http.verify_mode    = OpenSSL::SSL::VERIFY_NONE unless @ssl_strict
            http.use_ssl        = true

            response = http.request(request, payload)

            # Replace with the appropriate codes
            raise StandardError.new("Faulty Kiwi result: #{response.body}") unless ["AUTHORISED", "DECLINED"].include?(response.body)
            response.body == "AUTHORISED"
          end

          private

          # Take the posted data and move the relevant data into a hash
          def parse(post)
            @raw = post.to_s
            for line in @raw.split('&')
              key, value = *line.scan( %r{^([A-Za-z0-9_.-]+)\=(.*)$} ).flatten
              params[key] = CGI.unescape(value.to_s) if key.present?
            end
          end
        end
      end
    end
  end
end
