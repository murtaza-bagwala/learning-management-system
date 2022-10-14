# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_names = []
user_mobile_nos = []
course_titles = []

# Create unique names and mobile nos

30.times do
  name = Faker::Name.name
  mobile_no = Faker::PhoneNumber.cell_phone_in_e164.first(12)
  user_names << name unless user_names.include?(name)
  user_mobile_nos << mobile_no unless user_mobile_nos.include?(mobile_no)
end

# Create unique course_titles

48.times do
  course_title = Faker::Company.name
  course_titles << course_title unless course_titles.include?(course_title)
end

index = 0

# Create user then for each user create 4 course and for each course create 3 video lessons

6.times do |time|
  user = User.create!(name: user_names[time],
                      dob: Faker::Date.birthday(min_age: 18, max_age: 65),
                      mobile_no: user_mobile_nos[time],
                      email: Faker::Internet.email,
                      university: Faker::Educator.university,
                      organization: Faker::Company.name)

  puts("Author created #{user.name}")

  4.times do |_time|
    course = Course.create!(title: course_titles[index],
                            description: Faker::Quote.matz,
                            published_at: Date.today,
                            published: true,
                            user_id: user.id)

    puts("Course #{course.title} created for user #{user.name}")

    3.times do |lesson_time|
      lesson = Lesson.create!(
        title: "#{course_titles[index]} #{lesson_time}",
        notes: Faker::Quote.matz,
        course_id: course.id
      )
      lesson.video.attach(io: File.open('public/1mb-file.mp4'), filename: '1mb-file.mp4')

      puts("Lesson #{lesson.title} created for course #{course.title}")
    end

    index += 1
  end

  user_names.delete(user_names[time])
  user_mobile_nos.delete(user_mobile_nos[time])
end

course_ids = Course.all.pluck(:id)

index = 0

# Create talent for each course

6.times do |time|
  user = User.create!(name: user_names[time],
                      dob: Faker::Date.birthday(min_age: 18, max_age: 65),
                      mobile_no: user_mobile_nos[time],
                      email: Faker::Internet.email,
                      university: Faker::Educator.university,
                      organization: Faker::Company.name)

  puts("Talent created #{user.name}")

  3.times do |_time|
    UserCourse.create!(user_id: user.id, course_id: course_ids[index])
    index += 1
  end
end
