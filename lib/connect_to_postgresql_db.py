#/usr/bin/env python

###
#Nathaniel Watson
#nathankw@stanford.edu
###

import os
import urlparse
import psycopg2

#Heroku has some nice examples, including one for connecting to a PostgreSQL databse in Python. See
# https://devcenter.heroku.com/articles/heroku-postgresql#connecting-in-python

#Note that updating a RAILS backend database should really only happen through the models, so using the RAILS console or custom RAILS scripts that connect to your database.

urlparse.uses_netloc.append("postgres")
url = urlparse.urlparse(os.environ["DATABASE_URL"])
conn = psycopg2.connect(
    database=url.path[1:], #the first char is the '/'
    user=url.username,
    password=url.password,
    host=url.hostname,
    port=url.port
)

cur = conn.cursor()

