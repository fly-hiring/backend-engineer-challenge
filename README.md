# Backend Work Sample

Hello! This is a hiring project for our [Backend Engineer position](https://fly.io/jobs/backend-engineer/).
If you apply, we’ll ask you to do this project so we can see how you work through a contrived (yet shockingly accurate) example of the type of things you’d do at Fly.io.

# The Job

As a Backend Engineer at Fly.io, you’ll be working on the interfaces around our platform product. Checkout the [job post](https://fly.io/jobs/backend-engineer/) for the nitty gritty.

# Background Information

At the center of our backend infrastructure is `web`, a lovely Rails app that:

* Handles billing for a bunch of different things. Invoices are a combination of metered product usage, one off line items, and recurring subscription fees.
* Generates 10s of thousands of invoices each month.
* Models our global account data with concepts like `Organizations` and `Users`.
* Syncs data to Stripe, our payment processor, so we can bill developers for their usage.
* Serves the GraphQL API that powers `flyctl`, the command line tool developers use to interact with the platform (you don't need to know this for the work sample, but it's kinda cool).

Our current process for billing developers looks like this: we sync usage data from a variety of sources to Stripe, which generates an invoice based on Stripe's knowledge of our products and pricing.
The challenge is that we bill for a whole lot of things in tiny increments, so we need to sync usage data to Stripe _all the time_.
We sync to Stripe so aggressively that we sometimes fail to sync at all, which means we can't tell our users how much they owe.
The strategy of pushing usage data to Stripe reduces our ability to provide a good developer experience.

To solve this, we want to compile our own usage data and generate invoices in real-time.
Once an invoice is generated, we can sync the invoice, rather than the usage, to Stripe and use that to bill our customers.

In this project, you're going to build part of this new invoicing system.

## What We Want You to Do

This project comes with a basic [invoice model](app/models/invoice.rb) and [migration](db/migrate/20221027223051_create_invoices.rb), but it's incomplete.
We want you to build the remaining pieces of the invoice model (if anything is missing) as well as the invoice items (line items).
Don't worry about getting the underlying usage and pricing right -
if you need inspiration, you can work off the [Fly.io pricing page](https://fly.io/docs/about/pricing/), but your best guess is fine.

Once you have the models worked out, we want you to show us how you would sync invoices to Stripe.
**We don't want you to write to the actual Stripe API!**
Instead, we're interested in how you approach building this sync in a resilient, reliable way.
You can explain how you'd do this in the comments, _or_ you can write to the mock Stripe [library](lib/stripe.rb) included in the project.
This lib is there for to help you, give you ideas, and prevent you from wasting time learning the Stripe API or their Ruby library.
The details of the lib are documented in [STRIPE-README.md](lib/STRIPE-README.md).

We also want to see you query + aggregate invoices. Add a method to the `Invoice` model that summarizes invoice totals by month for multiple years.
Think hard about how many invoices we're dealing with. We want this method to be fast.

## What We're Looking For

We want you to show us two things:

1. You can build a database backed Rails to implement real life billing
1. You can solve problems for real life users. See `NOTES.md` down below

For the invoice modeling piece, we care about the types you choose and whether you model items in a way that emphasizes the things our users care about.
We want to see how you approached trade-offs and what you prioritize when making decisions for the migration.

For the Stripe sync, we want to see how you'd build resiliency to API errors, handle retries, and overall do the right thing when things go wrong.
The sync logic could be a rake task, a service class, a method/callback on a model; do what works for your mental model.

We care a lot about scope. You might be tempted to try and solve the whole big problem, but that's not what we want for this exercise.
We're asking for relatively focused work. When in doubt, go deeper before you go broader. Blowing out the scope is risky (this is true for people who work here, too).

Pro tip: "Background Information" is just that. We want you to understand the problem. We're not asking you to do extra work.

## NOTES.md

`NOTES.md` is here for _you_ to show us how you think about the problem and what you'd be thinking about if you were in charge of this feature at Fly.io.
Even though this project does not have a UI component, we're especially interested in how you think the billing experience should work for developers, and how you'd bubble up problems to users when things are _not_ working as they should.
We want to see you approach the exercise in a way that prioritizes the needs of our users.

Here's some examples of things to include in your notes file:

* What would you focus on to improve the experience around usage and billing?
* What columns could you add to the invoice/invoice item models that you think our users would find helpful?
* How would you run the Stripe sync in production? How do we maintain confidence that this sync continues to work?
* How would you communicate errors and problems to the user?
* Any other comments, questions, or thoughts that came up.

## Don't Do These

There's a lot of extra work you'd do in real life that we don't need to see here. Feel free to skip these things:

1. Don't spend time making this perfect or writing tests for every scenario.
2. Don't solve every edge case. Rough edges are fine if it helps you move quickly, and you can document your decisions and trade-offs in `NOTES.md`.
3. In real life, there's probably a lot more database schema. Don't worry about real life, just worry about what we're asking for.
4. Skip quality of life improvements. We're wary of code coverage tools, refactors, testing library changes, etc. We definitely don't want you to spend time on that stuff.

And last, if you know what you're doing, don't spend more than two hours on this. If you are learning, take all the time you need.
But if you're experienced with Rails and databases and and data consistency issues, this should be a quick project. 
