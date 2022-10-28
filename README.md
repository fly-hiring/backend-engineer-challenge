# Backend Work Sample

Hello! This is a hiring project for our [Backend Engineer position](TODO).
If you apply, we’ll ask you to do this project so we can see how you work through a contrived (yet shockingly accurate) example of the type of things you’d do at Fly.io.

# The Job

As a Backend Engineer at Fly.io, you’ll be working on the interfaces around our platform product. Checkout the [job post](TODO) for the nitty gritty.

# The Project

At the center of our backend infrastructure is `web`, a lovely Rails app that:

* Syncs usage data from the Fly.io platform so we can give developers insight into their platform usage. This is stuff like reserved CPU, memory usage over time, data in/out, and more. 
* Models our global account data with concepts like `Organizations` and `Users`.
* Syncs data to Stripe, our payment processor, so we can bill developers for their usage.
* Serves the GraphQL API that powers `flyctl`, the command line tool developers use to interact with the platform (you don't need to know this for the work sample, but it's kinda cool).

Our current process for billing developers looks like this: we sync usage data from a variety of sources to Stripe, which generates an invoice based on Stripe's knowledge of our products and pricing. The challenge is that we bill for a whole lot of things in tiny increments, so we need to sync usage data to Stripe all the time. We sync to Stripe so aggressively that we sometimes fail to sync at all, which means we can't tell our users how much they owe. The strategy of pushing usage data to Stripe reduces our ability to provide a good developer experience.

To solve this, we want to build our own usage data and generate invoices in real-time. Once invoices are generated, we can sync the invoice, rather than the usage, to Stripe and use that to bill our customers.

In this project, we're going to build part of this new invoicing system.

## Your Piece

This project comes with a [basic invoice model setup](link me), but it's incomplete. We want you to build out the model for an invoice as well as the invoice items (line items) in an invoice. (TODO: add note that they can use our billing page for the models). Then, we want you to show us how you would sync invoices to Stripe.

You don't have to write to the actual [Stripe API](https://stripe.com/docs/api), but we want to see how that would work. This is important data, so we care about reliabily syncing things and data integrity.

### Criteria

For the first part, we mostly want to see you model invoice items in a way that emphasizes the things users care about. Since there's no UI, feel free to use tests to make sure the model works as expected.

For the Stripe sync, [TBD].

Don’t spend time making this perfect. Rough edges are fine if it helps you move quickly, and you can document your decisions and trade-offs in `NOTES.md`.

Other good things to jot down in `NOTES.md` are:

* What would you focus on to improve the developer experience around usage and billing?
* How would you run the Stripe sync in production? How do we maintain confidence that this sync continues to work?
* Any other comments, questions, or thoughts that came up.
