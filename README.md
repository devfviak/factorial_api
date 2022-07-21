## Welcome

Hi! I'm Pedro and I've developed this API for learning purposes. The API is a small Ruby on Rails application which lets you:

1.  User authentication (sign up, sign in, etc)
2.  User management (get profile, update it...)
3.  Add expenses by user

It also handles:

*   Model validations
*   Tracking model instaces modifications
*   Payments webhooks from different payment processors

And of course. **TESTS**

## Setup

Let's start by setting up the app.  
  
Clone the repo

```plaintext
git clone git@github.com:devfviak/factorial_api.git
```

  
Install dependencies

```sh
bundle install
```

Make sure you have Mysql installed and create your own _database.yml_ file. (Follow the _database.yml.example_ in the project)

```sh
touch /config/database.yml
```

Setup env variables. Create an _.env_ file in project root folder with the following content:   
 

```plaintext
DB_USERNAME='your_mysql_db_user'
DB_PASSWORD='your_mysql_db_passwrd'

API_URL='http://localhost:3000'
FRONTEND_URL = 'http://localhost:5173'
```

## Run it
Once setup is done, you can start the server

```sh
rails s
```