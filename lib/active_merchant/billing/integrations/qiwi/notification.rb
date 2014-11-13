require 'net/http'
require 'base64'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Qiwi
        # Полезно смотреть тут: https://github.com/Shopify/active_merchant/commit/646919b4016ba75095acb69a029493d1075272ce
        # https://static.qiwi.com/ru/doc/ishop/protocols/Visa_QIWI_Wallet_Pull_Payments_API.pdf
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          #def complete?
          #  status == 'paid'
          #end

          def item_id
            params['order']
          end

          def transaction_id
            params['bill_id']
          end

          def amount
            BigDecimal.new(gross)
          end

          #def customer
          #  @options[:customer]
          #end

          # When was this payment received by the client.
          #def received_at
          #  params['']
          #end

          #def payer_email
          #  params['']
          #end

          #def receiver
          #  params['user']
          #end

          #def security_key
          #  params['']
          #end

          # the money amount we received in X.2 decimal.
          def gross
            params['amount']
          end

          # Was this a test transaction?
          #def test?
          #  false
          #end

          #def status
          #  params['status']
          #end

          # Acknowledge the transaction to Qiwi. This method has to be called after a new
          # apc arrives. Qiwi will verify that all the information we received are correct and will return a
          # ok or a fail.
          #
          # Example:
          #
          #   def ipn
          #     notify = QiwiNotification.new(request.raw_post)
          #
          #     if notify.acknowledge
          #       ... process order ... if notify.complete?
          #     else
          #       ... log possible hacking attempt ...
          #     end
          def acknowledge(notification_secret)
            #payload = raw
            prv_id = 260335

            authorization = Base64.urlsafe_encode64("#{prv_id}:#{notification_secret}")
            uri = URI.parse("https://w.qiwi.com/api/v2/prv/#{prv_id}/bills/#{transaction_id}")

            request = Net::HTTP::Get.new(uri.path)

            request['Authorization'] = "Basic #{authorization}"
            request['Accept'] = "text/json"
            #request['Content-Length'] = "#{payload.size}"
            request['Content-Type'] = "application/x-www-form-urlencoded; charset=utf-8"

            http = Net::HTTP.new(uri.host, uri.port)
            http.verify_mode    = OpenSSL::SSL::VERIFY_NONE# unless @ssl_strict
            http.use_ssl        = true

            response = http.request(request)
            logger = Logger.new('/home/mmopay/current/log/qiwi.log')
            logger.debug response.inspect
            logger.debug response.body.inspect

            true
            # Replace with the appropriate codes
            #raise StandardError.new("Faulty Qiwi result: #{response.body}") unless ["AUTHORISED", "DECLINED"].include?(response.body)
            #response.body == "AUTHORISED"
          end

          private

          # Take the posted data and move the relevant data into a hash
          #def parse(post)
          #  @raw = post.to_s
          #  for line in @raw.split('&')
          #    key, value = *line.scan( %r{^([A-Za-z0-9_.-]+)\=(.*)$} ).flatten
          #    params[key] = CGI.unescape(value.to_s) if key.present?
          #  end
          #end
        end
      end
    end
  end
end
