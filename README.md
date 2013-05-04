We're building a publicly-owned political dialogue platform.

As a nonprofit that's building open-source technology, Asq.Us is bridging the gap between you and your elected officials. 

This is the 'townhall' of the 21st century.

By using the internet, we can finally connect the people that make up America's democracy.

asq.us

=================
RUNNING THE CODE
=================

Requirements
------------
Ruby 1.9.3
rubygems
postgresql 


Install the Dependencies
------------------------

You will need to:

  * [Install git](http://git-scm.com/), a distributed version control system. Read the [Github Git Guides](http://github.com/guides/home) to learn how to use *git*.
  * [Install Ruby](http://www.ruby-lang.org/), a programming language. You can use MRI Ruby 1.9.3 (http://rubyenterpriseedition.com/). Your operating system may already have it installed or offer it as a pre-built package. (Good link for install RVM and Ruby 1.9 required for the new project. (http://jaysonrowe.blogspot.com/2012/04/installing-ruby-and-rails-on-fedora.html)
  * [Install RubyGems](http://rubyforge.org/projects/rubygems/) 1.8.x or newer, a tool for managing software packages for Ruby.
  * [Install Postgresql](http://www.postgresql.org/), a relational database. Your operating system may already have it installed or offer it as a pre-built package. We recommend installing it NOT from source, but from a package installer. (details below)
  * [Install Bundler](http://gembundler.com/), a Ruby dependency management tool. You should run `gem install bundler` as root or an administrator after installing Ruby and RubyGems.
  * Checkout the source code. Run `git clone git://github.com/asqus/asqus.git`. (Don't use eclipse because it will forget it checked out the source for you.) We put in a directory called 'asqus'.
  
 
Ruby Project Setup
-------------------

 * cd asqus
 * bundle install    # Install the ruby project deps.
 * bundle update
 
Postgresql
----------

 * Create database.yml file in config
 
development:
  	adapter: postgresql
  	database: asqus_dev
  	pool: 5
  	timeout: 5000
  	username: asqme
  	password: asqussorocks
  	host: localhost
  	port: 5432
  	
 * You need to create a database, a user, and grant that user privileges to database.
 * [good instructions](http://www.cyberciti.biz/faq/howto-add-postgresql-user-account/) 
 
License
-------

This program is provided under an MIT open source license.