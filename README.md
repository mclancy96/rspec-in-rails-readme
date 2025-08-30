# RSpec: RSpec in Rails

Welcome to Lesson 19! In this lesson, you'll learn how to set up and use RSpec in a Ruby on Rails application. We'll cover installing the `rspec-rails` gem, running the generator, and understanding the Rails-specific spec folder structure. This lesson assumes you know Rails but are new to automated testing and RSpec.

---

## Why Use RSpec in Rails?

RSpec is the de facto testing framework for Ruby and Rails. It helps you:

- Write readable, maintainable tests for your Rails models, controllers, requests, and features
- Catch bugs before they reach production
- Refactor with confidence

## Installing RSpec in a Rails App

Add the `rspec-rails` gem to your Gemfile in the `:development, :test` group:

```ruby
# Gemfile
# ...existing code...
group :development, :test do
  gem "rspec-rails"
end
```

Then run:

```zsh
bundle install
```

## Initializing RSpec

Run the RSpec generator to set up RSpec in your Rails app:

```zsh
rails generate rspec:install
```

This creates several files:

```zsh
.rspec
spec/
  rails_helper.rb
  spec_helper.rb
```

- `.rspec`: Configures RSpec's command-line options
- `spec/spec_helper.rb`: General RSpec configuration
- `spec/rails_helper.rb`: Loads Rails and configures Rails-specific RSpec features

## Rails-Specific Spec Folder Structure

Rails projects use a convention for organizing specs:

```zsh
spec/
  models/         # Model specs (ActiveRecord)
  requests/       # Request specs (API/controller)
  features/       # Feature/system specs (Capybara)
  controllers/    # (Older style; in modern Rails, prefer request specs for end-to-end testing of controllers)
  helpers/
  mailers/
  views/
  jobs/
  channels/
  support/        # Custom helpers, shared examples, etc.
```

**Why Request Specs?**

In modern Rails, request specs are preferred over controller specs because they test the full stack (routing, middleware, controller, and response) and better reflect how users interact with your app. Controller specs are more limited and are now considered legacy in Rails 7+.

**Example:**

```ruby
# /spec/models/user_spec.rb
RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(name: "Alice", email: "alice@example.com")
    expect(user).to be_valid
  end
end
```

## What’s the Difference Between spec_helper.rb and rails_helper.rb?

Both files help configure your test suite, but they serve different purposes:

- **spec_helper.rb** sets up RSpec itself—basic configuration, custom matchers, and helpers that don’t depend on Rails.
- **rails_helper.rb** loads Rails and configures Rails-specific features, so you can test models, controllers, requests, and features. It also requires spec_helper.rb.

If you’re writing plain Ruby tests, you only need spec_helper.rb. For Rails apps, you’ll almost always use rails_helper.rb.

---

## Practice Prompts

1. Add `rspec-rails` to a Rails app and run the generator. What files are created? (Use file path comments in your examples!)
2. Create a new model and write a basic spec for it in `spec/models/`. Run the test and see what happens if it fails—then fix it and run again.
3. Write a spec for an invalid model (e.g., missing a required attribute) and use `expect(user).not_to be_valid` to see how expectations work for failures.
4. Explore the `rails_helper.rb` and `spec_helper.rb` files. What does each configure? Write a one-sentence summary for each.

---

## Resources

- [RSpec Rails Documentation](https://relishapp.com/rspec/rspec-rails/docs)
- [Rails Guides: Testing with RSpec](https://guides.rubyonrails.org/testing.html#rspec)
- [Better Specs: Rails](https://www.betterspecs.org/#rails)

---

## What's Next?

Next: In Lesson 20, we’ll write model specs for validations and associations, and introduce FactoryBot. **Lab 6 will follow this lesson**, where you’ll apply what you’ve learned by writing specs for a Rails mini-app’s models. This is your chance to get hands-on with RSpec, FactoryBot, and Rails models before moving on.
