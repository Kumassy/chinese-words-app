# Chinese Words App
Learn some Chinese words on the Web to get a better grade in the final exam ;)

You can:
- create a user account and save your status across any devices
- put stars on difficult words
- register new words
- edit words

![learn-words](https://cloud.githubusercontent.com/assets/6278784/26492061/44d103fa-424d-11e7-96cb-40632f3ac270.png)

![edit-words](https://cloud.githubusercontent.com/assets/6278784/26492064/485b2622-424d-11e7-8f95-1522eb7f7767.png)

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

Launch Chrome and go to `localhost:3000`. Tap `Sign up` and follow instructions. Then, you have to confirm your email, but you cannot receive confirmation emails anymore. So, retrieve confirmation token from the database:

```
$ bundle exec rails dbconsole

sqlite> select email, confirmation_token from users;
you@example.com|****confirmation_token****
```

Go to http://localhost:3000/users/confirmation?confirmation_token=****confirmation_token**** and confirm your account.

### Update User Permission
The default permission of users is 'viewer', which means they can only view cards rather than register new words or edit cards info. Give a permission to your account as follows:

```
$ bundle exec rails dbconsole

sqlite> update users set role='manager' where id = 1;
```
