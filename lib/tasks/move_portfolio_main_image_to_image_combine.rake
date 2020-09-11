# frozen_string_literal: true

def log(row, object)
  filename = object.main_image.filename.base
  print "processing image #{row + 1} #{filename}... "
end

namespace :db do
  task migrate_portfolio: :environment do

    portfolios = Spree::Gallery.all
    puts "Migrating #{portfolios.size} portfolio images..."

    ActiveRecord::Base.transaction do
      portfolios.each_with_index do |portfolio, i|
        next unless portfolio.main_image.attached?

        log(i, portfolio)

        slider_image = portfolio.build_slider_image
        cropped_image = slider_image.build_cropped_image
        cropped_image.attachment.attach(portfolio.main_image.blob)
        puts 'done' if cropped_image.save
      end
    end
  end
end
