FactoryBot.define do
  factory :idea do
    title {Faker::TvShows::BigBangTheory.quote}
    description {Faker::Lorem.paragraph(sentence_count: 10)}
    association :user, factory: :user
  end
end
