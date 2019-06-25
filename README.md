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
Run seeds : `rails db:seed`

Add Admin User - create admin user `bundle exec rake spree_auth:admin:create`


Don't forget to add in admin CMS (http://localhost:3000/admin/editor_settings/edit) id of:
news_body

Осталось:
1. Товары и категории
2. Модель фото для страниц и новостей
3. Шаринг блок для новостей