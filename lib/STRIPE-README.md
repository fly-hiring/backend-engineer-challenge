# Stripe API lib

This is a thin lib meant to look a lot like the Stripe Ruby library.
This is meant to help you focus on the problem, rather than learning the Stripe API.

## Usage

```ruby
invoice = Stripe::Invoice.create(customer: "s_asdfasd")

invoice_item = Stripe::InvoiceItem.create(
  invoice: invoice.id,
  unit_amount_decimal: 0.1,
  quantity: 1,
)

# These stubbing strategies are available for both Invoice and InvoiceItem.
# We would suggest using these to prove things work in tests or for
# tinkering in the rails console.
Stripe::Invoice.retrieve_with({ customer: "s_asdfasd" }) do
  Stripe::Invoice.retrieve("asdf")
  # => #<Stripe::Invoice id: asdf, customer: s_asdfasd>
end
Stripe::Invoice.retrieve("asdf")
# => InvalidRequestError (because it couldn't "find" anything)

Stripe::Invoice.slow_with(10)
  Stripe::Invoice.retrieve("asdf") # waits 10 seconds
end

Stripe::Invoice.error_with(StandardError.new("broken")) do
  Stripe::Invoice.retrieve("asdf")
  # => StandardError("broken")

  Stripe::Invoice.retrieve("asdf")
  # => StandardError("broken")
end
```
