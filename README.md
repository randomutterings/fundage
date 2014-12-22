![Fundage Logo](https://raw.github.com/randomutterings/fundage/master/app/assets/images/logo.jpg)

[Fundage](http://onlineslangdictionary.com/meaning-definition-of/fundage) is a web application for tracking financial transactions between entities.  It was written as a coding excercise in [Ruby on Rails](http://rubyonrails.org/).  Feel free to use it, fork it, or modify it if you like.

[![Build Status](https://api.travis-ci.org/randomutterings/fundage.svg?branch=master)](http://travis-ci.org/randomutterings/fundage)

## Getting Started

This guide makes no assumptions about the reader's experience.  Basically, if you can point, click, and follow instructions, you should be able to get Fundage running locally.

* Install [Git](http://git-scm.com/) (distributed version control system), see [installation options](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

* Install [Ruby](https://www.ruby-lang.org/en/) (programming language) 2.1.1 or higher, see [installation options](https://www.ruby-lang.org/en/documentation/installation/).

* Install [RubyGems](http://guides.rubygems.org/) (software package manager for Ruby), see [installation options](https://rubygems.org/pages/download).

* Install [Bundler](http://bundler.io/) (gem dependency manager).
```
  gem install bundler
```

* Clone this code repository
```
  git clone https://github.com/randomutterings/fundage.git
```

* Install all other dependencies.
```
  cd fundage && \
  bundle install
```

* Create the database tables
```
  bundle exec rake db:migrate
```

* Load some seed data (optional)
```
  bundle exec rake db:seed
```

* Start the server
```
  bundle exec rails s
```

## Usage

* Point your browser at [http://localhost:3000](http://localhost:3000)

## The original requirements (as they were given to me)

Goal: Internal wallet transactional system (with front end)

Requirements:
* Based on relationships every entity e.g. User or Team should have their own defined "wallet" to which we could transfer money or withdraw
* Every request for credit/debit (deposit or withdraw) should be based on records in database for given model
* Every instance of a single transaction should have proper validations against required fields and their source and target wallet, e.g. from who we are taking money and transferring to whom? (Credits == source wallet == nil, Debits == target wallet == nil)
* Each record should be created in database transactions to comply with ACID standards
* Balance for given entity (example: User)

Tasks:
1. Architect generic wallet solution (money manipulation) between entities (User, Stock, Team or any other)
2. Create model relationships and validations for achieving proper calculations of every wallet

## Notes

I named entities, owners in the codebase (because they "own" a wallet). Currently, owners can be subclassed as either users or teams.  I'll be referring to them as owners throughout the rest of this README.

## Some questions for the product owners

Should more than 1 wallet per owner be allowed?
If not, we could gain performance by merging wallets and owners into a single table.
Should more than 1 deposit and 1 withdraw be allowed per entry?
Should owners be deletable? If so, what should happen to their wallets and entries?

## ToDo

Differentiate between normal and bottomless wallets in the UI.
Display balances dynamically when selecting wallets on the new entry screen.
Make the UI pretty.
Investigate adding a caching layer to hold wallet balances for scalability.  After persisting an Entry, update the cache by operating directly on the cached balance of every affected Wallet and queue a background task to re-calculate the cached balance from all persisted Amounts as a sanity check.  This would provide much better performance and still guarantee historical accuracy.  We can prevent bottlenecks at the database level by offloading the background task to another machine that could run 100% off a dedicated read replica except in the case of a sanity check failure where we might want to temporarily suspend a wallet and notify a human to investigate.

## Contributing

* Create a branch for your changes:

    git checkout -b <shiny-new-feature>

* Write unit tests for any code you add or modify (we use [Rspec](https://relishapp.com/rspec)).

* Make sure all unit tests pass:
```
  bundle exec rspec
```

* Make sure [Rubocop](https://github.com/bbatsov/rubocop) is happy
```
  bundle exec rubocop
```

* When everything is green, open a Pull Request on GitHub `https://github.com/randomutterings/fundage/compare/master...<shiny-new-feature>`

## Tips

* While developing, run [Guard](https://github.com/guard/guard) to watch your files for changes and run rspec and rubocop automatically
```
  bundle exec guard
```

## Bug reports

If you discover any bugs, feel free to create an issue on [GitHub](https://github.com/randomutterings/fundage/issues). Please add as much information as possible. We also encourage you to help even more by forking and sending us a pull request.

## Maintainers

* Chris Barnes (https://github.com/randomutterings)

## License

[MIT License](http://www.opensource.org/licenses/MIT)
