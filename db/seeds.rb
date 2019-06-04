#Spree::Core::Engine.load_seed if defined?(Spree::Core)
#Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
store = Spree::Store.first

if store.present?
  store.update({ default: true, name: "БКЗ" })

  store_id = store.id
  Spree::Page.create({ slug: "/", title: "БКЗ: Лофт кирпич в Тюмени. Богатая цветовая палитра кирпича ручной формовки и плитки в стиле Лофт.", body: " БКЗ", show_in_header: true, store_ids:[store_id], layout: 'home' })
  Spree::Page.create({ slug: "/factory", title: "О заводе", body: "О заводе", show_in_header: true, store_ids:[store_id]  })
  Spree::Page.create({ slug: "/products", title: "Продукция", body: "Продукция", show_in_header: true, store_ids:[store_id], layout: 'products'  })

  Spree::Page.create({ slug: "/about", title: "О нас", body: "О нас", show_in_header: true, store_ids:[store_id] })
  Spree::Page.create({ slug: "/factory/structure", title: "Структура предприятия", body: "Структура предприятия" })
  Spree::Page.create({ slug: "/factory/certificates", title: "Сертификаты и награды", body: "Сертификаты и награды" })
  Spree::Page.create({ slug: "/factory/partners", title: "Партнеры", body: "Партнеры" })
  Spree::Page.create({ slug: "/factory/vacancies", title: "Вакансии", body: "Вакансии" })
  Spree::Page.create({ slug: "/factory/documents", title: "Документы", body: "Документы" })
  Spree::Page.create({ slug: "/gallery", title: "Фотогалерея", body: "Фотогалерея", show_in_header: true, store_ids:[store_id] })
  Spree::Page.create({ slug: "/news", title: "Новости", body: "Новости", show_in_header: true, store_ids:[store_id]  })
  Spree::Page.create({ slug: "/contact", title: "Контакты", body: "Контакты", show_in_header: true, store_ids:[store_id]  })
  Spree::Page.create({ slug: "/contact/requisites", title: "Реквизиты", body: "Реквизиты" })
  Spree::Page.create({ slug: "/contact/feedback", title: "Обратная связь", body: "Обратная связь" })
  Spree::Page.create({ slug: "/contact/request-call", title: "Заказать звонок", body: "Заказать звонок" })
end
