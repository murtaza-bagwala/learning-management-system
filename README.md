# Learning Management System :books:

API only Rails app that
handles online courses, its author and talents. The API includes CRUD operations
for all these items. Also one important
feature is that when deleting an author, the course gets transferred to
another author. And if the new author was a talent of the transferred course then the course gets added to the list of `authored_courses` and removed from `learnt_courses` for the new author.

Also, I am not using any authentication library like `Devise`, we are just expecting the uuid for the users in requests.

## Prerequisites

This app uses :- 

- Ruby on Rails 6.0 
- Ruby 2.6.3 
- Postgres 13
- JSON API Resources from [master](https://github.com/cerebris/jsonapi-resources)
- Rspec for unit tests.

## Installation

- `git clone git@github.com:murtaza-bagwala/learning-management-system.git`

- `rvm use 2.6.3`

- `bundle i`

- `rename .env.example to .env and add the DATABASE_URL`

- `rails db:setup`. This will create the DB, run the migration and seed the initial data from `seeds.rb`

- `rails s`

- `rspec spec/. for testcases`

or if you are familier with docker then just run these commands

`docker-compose build` and `docker-compose up`

***note: docker-compose uses Dockerfile.local and there is another Dockefile which is created for fly.io deployment***

## Entity Relationship Diagram

An ERD Diagram, which mentions entities of the systems and their relationships. User can be an Author or a Talent, User `has_many` Authored Courses, Courses `has_many` Lessons, User `has_many` Learnt Courses through UserCourses and Course `has_many` Talents through UserCourses.

![alt](erd.png)

## Postman Collection

To verify all the actions, postman collection is also added, you can find it in a root of a folder with a name **Learning-Management-System.postman_collection.json**, You can download the same and run on Postman collection runner. Default `base_url` is set as `https://elearnio-rails-challenge.fly.dev` this is where this application is currently deployed.


## Current Application Infrastructure

Currently this application is deployed on [fly.io](https://www.fly.io) on 512MB shared CPU with 1 GB Postgres DB storage but as we scale out we might need to move this to some big machine providers like AWS/GCP etc.

As I am a big proponent of extreme programming and CI/CD is one of the most important pillars of it, so I have setup the Github Actions workflows for the same.

### CI

Before code gets merged to `main` branch, it runs 2 workflows.

1) Rubocop to findout any formatting issues.
2) Rspec unit tests to check if there are any failed testcases. I have written models and integration testcases. 

### CD

Now once CI passes successfully and code gets merged to `main` branch I have created another workflow `.github/workflows/fly.yml`  which deploys the latest code to fly.io 

## Future Application Infrastructure

Now if scale out in future then this is how our deployment architecture would look like:- 

![alt](future-infrastructure.png)

- Terraform scripts to set the up the infrastructure.
- Once the code is merged Circle CI would build and pushes the image the ECR
- Trigger the EKS to pull the images from ECR and create the .containers









