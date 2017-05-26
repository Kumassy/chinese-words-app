# Chinese Words App


## Installation
```
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```

Fill out `config/secrets.yml`


### Creating a User
```
$ bundle exec rails s -b 0.0.0.0
```

Launch Chrome and go `localhost:3000`

`Sign up` and follow instructions.

Then, you must confirm your email, but you cannot receive emails anymore. So, overwrite the database.

```
$ bundle exec rails dbconsole

sqlite> select email, confirmation_token from users;
you@example.com|****confirmation_token****
```

Go: http://localhost:3000/users/confirmation?confirmation_token=****confirmation_token****


### Update User Permission
The default permission of users is 'viewer', which means they cannot edit card info. Give permissions to your account as follows:

```
$ bundle exec rails dbconsole

sqlite> update users set role='manager' where id = 1;
```
