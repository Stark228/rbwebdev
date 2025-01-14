# Ruby on Rails Overview

## 1. Ruby on Rails MVC

Ruby on Rails (Rails) follows the **Model-View-Controller (MVC)** architecture, which separates the application into three main components:

- **Model**: Represents the data layer and the business logic of the application. It interacts with the database, defining the structure and behavior of data objects.
  
- **View**: Represents the presentation layer. Views handle the user interface and display data sent from the controller.

- **Controller**: Acts as an intermediary between the Model and View. It processes incoming requests, retrieves data from the Model, and renders the appropriate View.

The MVC architecture helps to organize code, making it modular, easier to maintain, and scalable.

---

## 2. Rails Boot Process

When a Rails application is started, it goes through several steps during its **boot process**:

1. **Loading Dependencies**: Rails loads necessary libraries, gems, and configurations from the `Gemfile` and `config/initializers`.
2. **Configuration**: Rails loads environment configurations (from `config/application.rb`, `config/environment.rb`, and specific environment files like `config/environments/development.rb`).
3. **Eager Load**: All application files, including classes, modules, and controllers, are loaded into memory, enabling Rails to be ready for requests.
4. **Request Handling**: Rails uses its routing system (`config/routes.rb`) to direct incoming HTTP requests to the appropriate controller and action, initiating the MVC flow.

The boot process ensures that the application is configured, dependencies are loaded, and resources are ready to handle web requests.

---

## 3. Database Fundamentals

### ORMs vs ODMs

- **ORM (Object-Relational Mapping)**: A technique that allows developers to interact with a relational database using object-oriented programming (OOP). It maps database tables to objects in the application. In Rails, **ActiveRecord** is an example of an ORM.
  
- **ODM (Object-Document Mapping)**: Similar to ORM but for document-based databases like MongoDB. It maps documents (JSON-like structures) to objects in the application.

### Active Record

**ActiveRecord** is the default ORM in Rails. It abstracts database interactions and provides a simple, object-oriented interface for querying and manipulating the database. With ActiveRecord, you can perform CRUD (Create, Read, Update, Delete) operations easily without writing raw SQL.

Key features of ActiveRecord include:

- **Models**: Each ActiveRecord model corresponds to a table in the database.
- **Associations**: Rails supports associations like `has_many`, `belongs_to`, and `has_one` for defining relationships between models.
- **Validations**: You can set rules for validating data before saving it to the database.
- **Migrations**: ActiveRecord provides a way to manage database schema changes in a version-controlled manner.
---


# Create Ruby on Rails Application
  * Create app with postgresql database
```
$ rails new app_name --database=postgresql
$ rails new app_name d=postgresql
```
can be also configured in config/database.yml manually

  * Run the project
```
$ rails s
```
---

### Model

  * Create model and migrations
```
$ rails g model User name:string password_digest:string
```

```
$ rails g model UserProduct name:string:index brand:string data:json user:references:index --primary-key-type=uuid --skip-migration
```

```
def change
    create_table :user_products do |t|
      t.string :name
      t.string :brand
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
end
```
Have to write UserProduct in cli but in Model naming convention is user_product and in migrations as user_products. Keep in mind that we will use UserProduct naming convention to call in controller.

```
$ rails g model Admin::UserProduct name:string brand:string user:references
```
- Model file: app/models/admin/user_product.rb
- Migration file: db/migrate/xxxxxx_create_admin_user_products.rb
---
  * Undo everything it created
```
$ rails d model User
```
### Active Record Associations
* `belongs_to:` Defines a one-to-one connection with another model.

    ```
    Post belongs_to :user
    ```

*  `has_many:` Defines a one-to-many connection with another model.
    ```
    User has_many :posts
    ```

* `has_one:` Defines a one-to-one connection with another model where the current model holds the foreign key.
    ```
    User has_one :profile
    ```

* `has_and_belongs_to_many:` Defines a many-to-many connection with another model, using a join table.
    ```
    User has_and_belongs_to_many :groups
    ```

* `has_many :through:` Defines a many-to-many connection with another model, but using a third model (join model).
    ```
    User has_many :comments, through: :posts
    ```

### Options for Associations

* `class_name:`
    If your model name doesn’t match the association name, you can use class_name to link it properly.
    ```
    class Employee < ApplicationRecord
      has_many :projects, class_name: "Project"
    end
    ```

  * `foreign_key:`
  Specifies the foreign key used for the association if it doesn’t follow Rails’ default naming convention.
  ```
  class Comment < ApplicationRecord
    belongs_to :post, foreign_key: "custom_post_id"
  end
  ```
  * `primary_key:`
  Specifies the column to use as the primary key for the association (default is id).
  ```
  class Comment < ApplicationRecord
    belongs_to :post, primary_key: "slug" 
  end
  ```
  * `dependent:`
  Determines what happens to associated records when the parent record is destroyed or deleted.
  Usage: You can use :destroy, :delete_all, or :nullify to control this behavior.
  Options:
  - `:destroy` Calls destroy on each associated object (which also triggers callbacks and validations).
  - `:delete_all` Deletes the associated objects directly from the database without callbacks or validations.
  - `:nullify` Sets the foreign key to NULL instead of deleting the associated object.
  - `:estrict_with_exception` Cannot delete parent without clearing child.

 
  ```
  class User < ApplicationRecord
    has_many :posts, dependent: :destroy
  end
  ```

* `source:`
Used with has_many :through or has_and_belongs_to_many to specify the source of the association when the name of the join table column does not match the model name.
Usage: This option helps Rails identify the source for an association.
  ```
  class User < ApplicationRecord
    has_many :posts
    has_many :comments, through: :posts, source: :comment
  end
  ```
  Here, Rails knows that comments is the associated model through the posts join table.

* `inverse_of:`
Used to specify the inverse of the association. This is important in cases where Rails needs to optimize queries and ensure that objects are correctly loaded.
Usage: It’s often useful in complex models with bidirectional associations.
  ```
  class Post < ApplicationRecord
    belongs_to :user, inverse_of: :posts
  end

  class User < ApplicationRecord
    has_many :posts, inverse_of: :user
  end
  ```
  Here, Rails knows that the user associated with a post is the same user in the has_many :posts association, which helps improve performance and avoids unnecessary queries.

* `autosave:`
Determines whether associated records are automatically saved when the parent record is saved.
Usage: You can enable or disable autosaving of associated records.
  ```
  class User < ApplicationRecord
    has_many :posts, autosave: true
  end
  ```
  If autosave: true, Rails will automatically save any new or modified posts when the User is saved.

* `validate:`
Determines whether Rails will run validations on the associated records when the parent record is saved.
Usage: You can enable or disable validation for associated models.
  ```
  class User < ApplicationRecord
    has_many :posts, validate: false # Does not validate the associated posts
  end
  ```
* `scope:`
Defines a custom scope to filter the associated records. It allows you to specify a condition for the association.
Usage: Useful when you want to limit the records returned by the association.
  ```
  class User < ApplicationRecord
    has_many :active_posts, -> { where(active: true) }, class_name: "Post"
  end
  ```
  In this case, active_posts will only return posts where active = true.

### validations
---

### When Validations Run
- `save`
- `save!`
- `create`
- `create!`
- `update`
- `update!`
---

## Built-in Validation Helpers

### Presence
Ensures that an attribute is not `nil` or an empty string.
```ruby
class User < ApplicationRecord
  validates :name, presence: true
end
```

### Uniqueness
Ensures the value of an attribute is unique in the database.
```ruby
class User < ApplicationRecord
  validates :email, uniqueness: true
end
```
> **Note:** Use a database-level unique index for full protection.

### Length
Validates the length of an attribute's value.
```ruby
class User < ApplicationRecord
  validates :username, length: { minimum: 5, maximum: 20 }
end
```
Options:
Options:
- `minimum`: Ensures the length is at least the given value.
- `maximum`: Ensures the length does not exceed the given value.
- `in`: Ensures the length falls within the specified range (e.g., `in: 5..20`).
- `is`: Ensures the length is exactly the specified value (e.g., `is: 10`).

### Numericality
Ensures an attribute is numeric.
```ruby
class Product < ApplicationRecord
  validates :price, numericality: { greater_than: 0 }
end
```
Options:
- `greater_than`: Ensures the value is strictly greater than a given number.
  ```
  validates :price, numericality: { greater_than: 0 }
  ```
- `greater_than_or_equal_to`: Ensures the value is greater than or equal to a given number.
  ```
  validates :age, numericality: { greater_than_or_equal_to: 18 }
  ```
- `less_than`: Ensures the value is strictly less than a given number.
  ```
  validates :discount, numericality: { less_than: 1.0 }
  ```
- `less_than_or_equal_to`: Ensures the value is less than or equal to a given number.
  ```
  validates :seats, numericality: { less_than_or_equal_to: 100 }
  ```
- `odd`: Ensures the value is an odd number.
  ```
  validates :position, numericality: { odd: true }
  ```
- `even`: Ensures the value is an even number.
  ```
  validates :level, numericality: { even: true }
  ```

### Format
Validates an attribute against a regular expression.
```
class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
```

### Inclusion/Exclusion
Validates inclusion or exclusion of a value in a given set.
```
class User < ApplicationRecord
  validates :role, inclusion: { in: %w(admin user guest) }
  validates :username, exclusion: { in: %w(admin superuser) }
end
```

### Acceptance
Used for boolean-like fields (e.g., terms of service agreement).
```
class User < ApplicationRecord
  validates :terms_of_service, acceptance: true
end
```

### Confirmation
Ensures two fields match (e.g., `password` and `password_confirmation`).
```
class User < ApplicationRecord
  validates :password, confirmation: true
end
```

---

## Custom Validations
You can define custom validations within the model.
```
class User < ApplicationRecord
  validate :email_domain_check

  private

  def email_domain_check
    unless email.end_with?('@example.com')
      errors.add(:email, "must be from example.com domain")
    end
  end
end
```

---

## Conditional Validations
Run validations only under certain conditions.
```
class User < ApplicationRecord
  validates :password, presence: true, if: :password_required?

  private

  def password_required?
    new_record? || password.present?
  end
end
```

Options:
- `:if`
- `:unless`

---

## Common Keywords

| Keyword         | Description                                         |
|-----------------|-----------------------------------------------------|
| `on`            | Specifies when validation should occur (e.g., `:create`, `:update`). |
| `message`       | Custom error message for validation failure.        |
| `allow_nil`     | Skips validation if the attribute is `nil`.         |
| `allow_blank`   | Skips validation if the attribute is blank.         |
| `strict`        | Raises `ActiveModel::StrictValidationFailed` on failure. |
| `if`/`unless`   | Executes validation conditionally.                  |

---

### Using `on`
```
class Order < ApplicationRecord
  validates :credit_card_number, presence: true, on: :create
end
```

### Custom Validation with Conditional Logic
```
class Product < ApplicationRecord
  validate :expiration_date_cannot_be_in_the_past, if: :expiration_date_present?

  private

  def expiration_date_cannot_be_in_the_past
    if expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end

  def expiration_date_present?
    expiration_date.present?
  end
end
```

---

# Callbacks

Callbacks in Ruby on Rails are methods that are automatically triggered at certain points in the lifecycle of an ActiveRecord object. These methods allow you to run specific logic before or after certain actions, like saving, updating, or destroying an object. Callbacks are useful for tasks like data validation, sending notifications, or managing associations.

Callbacks are defined within the model class and are triggered automatically during specific stages of the object lifecycle. They are defined using methods such as `before_save`, `after_create`, or `before_destroy`, among others.


## Types of Callbacks

Callbacks can be broadly divided into three categories based on when they are triggered:

### Creation Callbacks  
These callbacks occur when an object is created (saved for the first time).

- `before_validation`  
  Triggered before validations are run.
- `after_validation`  
  Triggered after validations are run.
- `before_create`  
  Triggered before the record is created in the database.
- `after_create`  
  Triggered after the record is created in the database.

### Update Callbacks  
These callbacks occur when an existing object is updated.

- `before_save`  
  Triggered before the object is saved, regardless of whether it is a new or updated record.
- `before_update`  
  Triggered before an existing object is updated in the database.
- `after_save`  
  Triggered after the object is saved to the database.
- `after_update`  
  Triggered after the object is updated in the database.

### Destruction Callbacks  
These callbacks occur when an object is destroyed (deleted from the database).

- `before_destroy`  
  Triggered before the object is destroyed.
- `after_destroy`  
  Triggered after the object is destroyed.
- `around_destroy`  
  Executes code both before and after the object is destroyed. Can be used to wrap the destruction in a transaction-like manner.

## Common Callbacks

Some of the most commonly used callbacks are:

- `before_save`: Triggered before the object is saved, regardless of whether it's a create or update.
- `after_save`: Triggered after the object is saved, whether created or updated.
- `before_create`: Called before a new record is created.
- `after_create`: Called after a new record is created.
- `before_update`: Called before an existing record is updated.
- `after_update`: Called after an existing record is updated.
- `before_destroy`: Called before a record is destroyed.
- `after_destroy`: Called after a record is destroyed.

## Callback Execution Order

Callbacks are executed in a particular order. This order is essential to understand to avoid unexpected results.

### Example of the order of execution:

1. `before_validation`
2. `after_validation`
3. `before_save`
4. `before_create` (only for new records)
5. `create` (insert into DB)
6. `after_create` (only for new records)
7. `after_save`

For update operations, `before_create` and `after_create` are skipped, and `before_update` and `after_update` are used instead.

## Using Callbacks

Callbacks are defined in your ActiveRecord model class. Here's how to use them:

```
class User < ApplicationRecord
  before_save :normalize_name
  after_create :send_welcome_email
  before_destroy :check_associations

  private

  def normalize_name
    self.name = name.titleize
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  def check_associations
    throw(:abort) if orders.any?
  end
end
```
https://guides.rubyonrails.org/active_record_callbacks.html
---

# Migrations
  * Create database

  ```
  $ rake db:create
  ```
  * Create migrations
  ```
  $ rails g migration CreateUsers name:string email:string age:integer
  ```
  * Migrate
  ```
  $ rake db:migrate:status
  ```
  * Reset and migrate new
  ```
  $ rails db:migrate:reset:status
  ```
  * Rollback
  ```
  $ rails db:rollback STEP=3
  ```
  * Seed
  ```
  $ rails db:seed
  ```
https://guides.rubyonrails.org/active_record_migrations.html
---
# Scope
To define a scope, use the `scope` method inside your model. The `scope` method takes two parameters:
1. The name of the scope (a symbol).
2. A lambda or block that defines the query logic.

```
class Post < ApplicationRecord
  scope :published, -> { where(published: true) }

  scope :recent, -> { where('created_at >= ?', 1.week.ago) }
end
```
* Call in controller
```
Post.published
```
* Chaining Scopes
```
Post.published.recent
```
---
# Enum
Define in model
```
enum status: { draft: 0, published: 1, archived: 2 }
```
---
# Routes
url control by show method in users_controller
```
get "/users/:id", to: "users#show", as: "user"
```
In controller show method
```
@user = User.find(params[:id])
```
In erb
```
<%= link_to 'User Record', user_path(@user) %>
```
Nested route
```
resources :brands, except: [:destroy] do
    resources :products, only: [:index, :show]
end
```
Group route
```
namespace :admin do
  resources :articles
end
```
Using module
* If you want to route /articles (without the prefix /admin) to Admin::ArticlesController, you can specify the module with a scope block:
```
scope module: "admin" do
  resources :articles
end

resources :articles, module: "admin"
```
* Alternatively, you can also route /admin/articles to ArticlesController (without the Admin:: module prefix). You can specify the path with a scope block:
```
scope "/admin" do
  resources :articles
end

resources :articles, path: "/admin/articles"
```
```
resources :publishers do
  resources :magazines do
    resources :photos
  end
end
```
17. Controller
18. Views(erb)

Testing with Rspec, Capybara, FactoryBot, Feature testing,Test data setup, TDD
Cron jobs
Background Jobs
File Uploads
Third party integrations, like stripe
SDLC
