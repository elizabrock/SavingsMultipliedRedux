SavingsMultiplied
-----------------

This is an example application implementation for my Nashville Software School students.


Setup
=====

* Ruby Version: 2.1.1
* System Dependencies: phantomjs
* Configuration
    1. *Copy* config/database.yml.example to config/database.yml
    2. Change any database settings in config/database.yml (*NOT* the example file) that are necessary for your machine.

* Database creation
    1. `rake db:create:all`
    2. `rake db:migrate`
* Database initialization
    1. `rake db:seed`
* How to run the test suite
    1. `rake`
* Services (job queues, cache servers, search engines, etc.)
    * N/A
* Deployment instructions
    * N/A yet
