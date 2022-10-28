# Backend Work Sample

Hello! This is a hiring project for our [Backend Engineer position](TODO).
If you apply, we’ll ask you to do this project so we can see how you work through a contrived (yet shockingly accurate) example of the type of things you’d do at Fly.io.

# The Job

As a Backend Engineer at Fly.io, you’ll be working on the interfaces around our platform product. Checkout the [job post](TODO) for the nitty gritty.

# The Project

Fly.io is comprised of a few layers.
The layer we care about for Backend is ironically pretty close our Users.
We care about the APIs, interfaces that touch the APIs, and the data we store to create good user experiences.

One core piece to that layer is `web`, a lovely Rails app that:

* Syncs usage data from the Fly.io platform so we can give developers insight into their platform usage. This is stuff like reserved CPU, memory usage over time, data in/out, and more.
* Serves the GraphQL API that powers `flyctl`, the command line tool developers use to interact with the platform.
* Models our global account data with concepts like `Organizations` and `Users`.
* Syncs data to Stripe, our payment processor, so we can bill developers for their usage.

Our current process for billing developers looks like this: we sync usage data from a variety of sources to Stripe, which generates an invoice based on Stripe's knowledge of our products and pricing. The challenge is that we bill for a whole lot of things in tiny increments, so we need to sync usage data to Stripe all the time. We sync so aggressively that we sometimes fail to sync at all, which means we can't tell our users how much they owe. The strategy of pushing usage data to Stripe reduces our ability to provide a good developer experience.

To solve this, we want to build our own usage data and generate invoices in real-time. Once invoices are generated, we can sync the invoice, rather than the usage, to Stripe and use that to bill our customers.

In this project, we're going to build part of this invoicing system and take control of the user experience.

## Part 1: Invoice modeling

This project comes with a [basic Invoice model setup](link me), but it's incomplete. We want you to build out the model we'd use for the Invoice Items (line items) in an invoice.

### Critieria

* How did you model money between Invoices, items
* Do the Rails relationships make sense
* Are there reasonable database indexes?
* Since we don't have a presentation layer for this, illustrate your model tests
  - What's the total for an invoice?

Don’t spend time making this perfect. Rough edges are fine if it helps you move quickly. It’s okay to skip the last 20% to make it production ready, but you should know what that 20% is and explain it in the `NOTES.md`.

## Part 2: Stripe Sync

We have an Invoice with Invoice Items now.
We will need to sync these to Stripe so we can use them to bill our customers.
We want you to write code that illustrates the sync.
You don't have to write to the actual [Stripe API](https://stripe.com/docs/api), but we want to see how that would work.
This is important data, so we care about reliabily syncing things, and data integrity.

### Criteria

* Code that illustrates the sync
* Code that handles failures
* Code that handles retries
* Code that handles data integrity
* Explanation or illustration in code of how to deal with concurrent syncs (or how we'd avoid that)
* Explanation of what types of metrics we'd want to track for validity, reliability
* Its ok to expand in `NOTES.md` for things that are more involved that you aren't able to get to
* Don't worry about tests here unless it's helpful for your process

## Finishing up

In `NOTES.md` explain clearly:
* What types of End-User UX things come to mind with this project?
  Is there anything you would call out or focus on to make the expierence better for users?
* How would you run the sync in production?
* What is otherwise left to do to take a concept like this to production?
  How do we maintain confidence it continues to work?
* Do you have any feedback for us? What did you like? What could we do better?
* Other comments?
