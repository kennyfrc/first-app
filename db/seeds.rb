 require 'faker'
 
 # Create Posts
 50.times do
   Post.create!(
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   )
 end
 posts = Post.all
 
 # Create Comments
 100.times do
   Comment.create!(
     post: posts.sample,
     body: Faker::Lorem.paragraph
   )
 end

 # Create Advertisment

 Advertisement.create!(
    title: "Le Fwuff Bistwo",
    copy: "Steak, Spinach, Fwuff, and Fwop in Bear Bistwo",
    price: "1"
  )

 advertisements = Advertisement.all
 
 # Create Questions
 50.times do
  Question.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    resolved: (1 == rand(2) ? true : false)
  )

 questions = Question.all
end

 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
 puts "#{Advertisement.count} advertisements created"
 puts "#{Question.count} advertisements created"