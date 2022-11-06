module Stripe
  StripeError = Class.new(StandardError)
  APIError = Class.new(StripeError)
  OAuthError = Class.new(StripeError)
  AuthenticationError = Class.new(StripeError)
  APIConnectionError = Class.new(StripeError)
  RateLimitError = Class.new(StripeError)
  TimeoutError = Class.new(StripeError)
  InvalidRequestError = Class.new(StripeError)

  module Harness
    module ClassMethods
      def error_with(error)
        @errors ||= []
        len = @errors.length
        @errors << error
        yield
      ensure
        @errors.pop if len > @errors.try(:length).to_i
      end

      def slow_with(time_seconds)
        @slow_times ||= []
        len = @slow_times.length
        @slow_times << time_seconds
        yield
      ensure
        @slow_times.pop if len > @slow_times.try(:length).to_i
      end

      def retrieve_with(params)
        @retrieve_params ||= []
        len = @retrieve_params.length
        @retrieve_params << params
        yield
      ensure
        @retrieve_params.pop if @retrieve_params.try(:length).to_i > len
      end

      def create(params)
        check_error!
        check_slow!

        new(params)
      end

      def retrieve(id)
        check_error!
        check_slow!

        if @retrieve_params.try(:length).to_i > 0
          new({id: id}.merge(@retrieve_params.last))
        else
          raise Stripe::InvalidRequestError, "No such invoice: '#{id}'"
        end
      end

      def check_slow!
        sleep @slow_times.last if @slow_times.try(:length).to_i > 0
      end

      def check_error!
        raise @errors.last if @errors.try(:length).to_i > 0
      end
    end

    def update_attributes(params)
      self.class.check_error!
      self.class.check_slow!

      assign_attributes(params)
    end
  end

  class Invoice
    extend Harness::ClassMethods
    include Harness

    attr_reader :customer

    def initialize(params)
      @id = params[:id] || id
      assign_attributes(params)
    end

    def id
      @id ||= SecureRandom.base36
    end

    private

    def assign_attributes(params)
      @customer = params[:customer]
      @invoice = params[:invoice]
      @unit_amount_decimal = params[:unit_amount_decimal]
      @quantity = params[:quantity]
    end
  end

  class InvoiceItem
    extend Harness::ClassMethods
    include Harness

    attr_reader :invoice
    attr_reader :unit_amount_decimal
    attr_reader :quantity

    def initialize(params)
      @id = params[:id] || id
      assign_attributes(params)
    end

    def id
      @id ||= SecureRandom.base36
    end

    private

    def assign_attributes(params)
      @invoice = params[:invoice]
      @unit_amount_decimal = params[:unit_amount_decimal]
      @quantity = params[:quantity]
    end
  end
end
