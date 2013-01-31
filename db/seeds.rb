BicycleCms::User.create!(
  { id: 1,
  name: 'admin',
  email: 'email@example.com',
  password: 'password',
  is_admin: true,
  profile: BicycleCms::Profile.create!(
    { name: 'Administrator',
      gender: 'undefined',
      user_id: 1 },
    without_protection: true) },

  without_protection: true
)

BicycleCms::Category.create!(
  { id: 1,
  is_published: true,
  title: 'Root Category',
  slug: 'root' },

  without_protection: true
)

BicycleCms::Article.create!(
  { id: 1,
  is_published: true,
  published_at: Time.now,
  category_id: 1,
  author_id: 1,
  title: 'First Article',
  slug: 'home',
  body: 'Welcome abrod!',
  is_page: true },

  without_protection: true
)
