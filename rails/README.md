1. Ruby on Rails MVC
2. Rails boot process
3. Database fundamentals
    * ORMs vs ODMs
    * Active Record


1. Create Ruby on Rails Application
  * Create app with postgresql database
```
$ rails new app_name --database=postgresql
```
can be also configured in config/database.yml manually

  * Run the project
```
$ rails s
```

14. Model

  * Create model and migrations
```
$ rails g model User name:string password_digest:string
```

    * Undo everything it created
```
$ rails d model User
```


    * Model naming convention is CreateAt, UserProduct
  * In model, you can make relations using Active Record Associations
    - belongs_to :company
    - has_one :role
    - has_many :post
    - has_many :through
    - has_one :through
    - has_and_belongs_to_many

15. Migrations
  * Create database
```
$ rake db:create
```

  * 

16. Routes
17. Controller
18. Views(erb)
19. assets

Testing with Rspec, Capybara, FactoryBot, Feature testing,Test data setup, TDD
Cron jobs
Background Jobs
File Uploads
Third party integrations, like stripe
SDLC
