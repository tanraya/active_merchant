module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module YandexMoney
        # https://money.yandex.ru/doc.xml?id=526537
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          # Идентификатор Контрагента, выдается Оператором.
          mapping :account, 'shopId'

          # Стоимость заказа.
          mapping :amount, 'sum'

          # Уникальный номер заказа в ИС Контрагента. Уникальность контролируется Оператором
          # в сочетании с параметром shopId. Если платеж с таким номер заказа уже был успешно
          # проведен, то повторные попытки оплаты будут отвергнуты Оператором.
          mapping :order, 'orderNumber'

          # Идентификатор плательщика в ИС Контрагента. В качестве идентификатора может
          # использоваться номер договора плательщика, логин плательщика и т. п.
          # Возможна повторная оплата по одному и тому же идентификатору плательщика.
          mapping :customer_id, 'customerNumber'

          # Номер витрины Контрагента, выдается Оператором.
          mapping :scid, 'scid'

          # Идентификатор товара, выдается Оператором. Применяется, если Контрагент
          # использует несколько платежных форм для разных товаров.
          mapping :shop_article_id, 'shopArticleId'

          # URL, на который нужно отправить плательщика в случае успеха перевода.
          # Используется при выборе соответствующей опции подключения Контрагента
          # (см. раздел 6.1 «Параметры подключения Контрагента»).
          mapping :return_shop_success_url, 'shopSuccessURL'

          # URL, на который нужно отправить плательщика в случае ошибки оплаты.
          # Используется при выборе соответствующей опции подключения Контрагента.
          mapping :return_shop_failure_url, 'shopFailURL'

          # URL, по которому ИС Контрагента будет доступна для запросов
          # Оператора «Уведомление о переводе». Для взаимодействия необходимо использовать протокол HTTPS.
          mapping :payment_aviso_url, 'paymentAvisoURL'

          # URL, по которому ИС Контрагента будет доступна для запросов Оператора «Проверка заказа».
          # Для взаимодействия необходимо использовать протокол HTTPS.
          mapping :check_url, 'checkURL'

          # ???
          mapping :return_success_url, 'successURL'
          mapping :return_failure_url, 'failURL'
          mapping :bank_id, 'bankId'

          def initialize(order, account, options = {})
            @_secret = options.delete(:secret)
            @_scid = options.delete(:scid)
            super
            @fields[mappings[:scid]] = @_scid
          end

          def account
            @fields[mappings[:account]]
          end

          def scid
            @fields[mappings[:scid]]
          end

          def params
            @fields
          end

          def secret
            @_secret
          end

          def form_fields
            @fields
          end
        end
      end
    end
  end
end
