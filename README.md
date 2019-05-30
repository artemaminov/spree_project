# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


ruby -v `2.5.5`
Rails -v `5.2.3`


First run:
Run migration: `rails db:migrate`

Add Admin User - create admin user `bundle exec rake spree_auth:admin:create`