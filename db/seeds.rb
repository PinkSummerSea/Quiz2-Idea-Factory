Like.destroy_all
Review.destroy_all
Idea.destroy_all
User.destroy_all

summer = User.create(
    first_name: "Summer",
    last_name: "Lin",
    email: "lin.summer@outlook.com",
    password: "123"
)

20.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}@#{last_name.downcase}.com",
        password: "123"
    )
end

users = User.all 

30.times do
    idea = Idea.create(
        title: Faker::TvShows::BigBangTheory.quote,
        description: Faker::Lorem.paragraph(sentence_count: 10),
        user: users.sample
    )

    if idea.valid?
        rand(5..10).times do
            review = Review.create(
                body: Faker::TvShows::TheITCrowd.quote,
                idea: idea,
                user: users.sample
            )
        end
        
        idea.likers = users.shuffle.slice(0, rand(users.count))
    end
end
