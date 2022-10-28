# Backend Work Sample

Hello! This is a hiring project for our [Platform Engineer position](TODO).
If you apply, we’ll ask you to do this project so we can see how you work through a contrived (yet shockingly accurate) example of the type of things you’d do at Fly.io.

# The Job

As a Backend Engineer at Fly.io, you’ll be working on the interfaces around our platform product. Checkout the [job post](TODO) for the nitty gritty.

# The Project

Fly.io is comprised of a few layers.
The layer we care about for Backend is ironically pretty close our Users.
We care about the APIs, interfaces that touch the APIs, and the data we store to create good user experiences.

One core piece to that layer is `web`.
It's a Rails app that that does a lot of stuff:

* Serves our GraphQL API
* Manages much of our centralized job processing
* Stores our global account data like Organizations, Users
* Syncs data from our platform to provide strong, encompassing user experiences to our UIs
* Syncs data to Stripe to bill our users

Today, we rely heavily on Stripe by syncing usage data to Stripe that they then bill for us.
We sync so aggressively that we sometimes fail to sync.
The strategy of pushing usage data to Stripe also removes some control, reduces our ability to provide better experiences for our users.

We will be changing our strategy to build our own usage data at invoice-time.
Once those invoices are generated we'll sync the invoice, rather than usage, to Stripe and use that to bill customers.

In this project, we're going to work on some of the Invoice piece.

## Part 1: Invoice modeling

This project has a basic Invoice model setup, but it's incomplete.
We want you to build out the model we'd use for the Invoice Items (line items) in an invoice.
You might notice there are some things missing on the Invoice model, please add them.

### Critieria

* How did you model money between Invoices, items
* Do the Rails relationships make sense
* Since we don't have a presentation layer for this, illustrate your model tests
  - What's the total for an invoice?
* Don’t spend time making this perfect. Rough edges are fine if it helps you move quickly. It’s okay to skip the last 20% to make it production ready, but you should know what that 20% is and explain it in the `NOTES.md`.

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
