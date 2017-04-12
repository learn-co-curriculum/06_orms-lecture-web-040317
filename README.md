## Object Relational Mapper (ORM)

+ Objects in our Object Oriented Application that should correspond/map to our database somehow

## Active Record Pattern 

# CRUD REVIEW

A tweet belongs to a user and has some message content  - must have user_id

The belongs_to must have a user_id on it

A user has a username, and has many tweets

A tweet can have many tags and a tag can have many tweets

tweet_tag

How would we find all of the tweets that are tagged 'YOLO'?

```SQL
SELECT * FROM tweets
INNER JOIN tweet_tags
ON tweet_tags.tweet_id = tweets.id
INNER JOIN tags
ON tags.id = tweet_tags.tag_id
WHERE tags.name = 'YOLO'
```
### BONUS

A user can follow many other users
