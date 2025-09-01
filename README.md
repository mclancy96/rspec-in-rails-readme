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

## Getting Hands-On: Clinic App (Patient & Appointment)

Ready to practice? Here’s how to get started with the Clinic Rails app:

1. **Fork and Clone** this repo to your local machine.
2. **Install dependencies:**

   ```zsh
   bundle install
   ```

3. **Set up the database:**

   ```zsh
   bin/rails db:migrate
   ```

4. **Run the test suite:**

   ```zsh
   bin/rspec
   ```

5. **Implement the pending specs:**
   - Open `spec/models/patient_spec.rb` and `spec/models/appointment_spec.rb`.
   - Look for specs marked with `pending`. Implement the corresponding methods in `app/models/patient.rb` and `app/models/appointment.rb` so all specs pass.

### Example: Patient Model Spec

```ruby
# spec/models/patient_spec.rb
RSpec.describe Patient, type: :model do
  it 'is valid with valid attributes' do
    patient = Patient.new(name: 'John Doe', date_of_birth: '1980-01-01')
    expect(patient).to be_valid
  end
  # ...more examples...
end
```

### Example: Appointment Model Spec

```ruby
# spec/models/appointment_spec.rb
RSpec.describe Appointment, type: :model do
  it 'is valid with valid attributes' do
    appointment = Appointment.new(patient: patient, scheduled_at: 1.day.from_now, reason: 'Checkup')
    expect(appointment).to be_valid
  end
  # ...more examples...
end
```

---

## Resources

- [RSpec Rails Documentation](https://relishapp.com/rspec/rspec-rails/docs)
- [Rails Guides: Testing with RSpec](https://guides.rubyonrails.org/testing.html#rspec)
- [Better Specs: Rails](https://www.betterspecs.org/#rails)

---

## What's Next?

Next: In Lesson 20, you’ll write model specs for validations and associations, and introduce FactoryBot. **Lab 6 will follow this lesson**, where you’ll apply what you’ve learned by writing specs for a Rails mini-app’s models. This is your chance to get hands-on with RSpec, FactoryBot, and Rails models before moving on.
