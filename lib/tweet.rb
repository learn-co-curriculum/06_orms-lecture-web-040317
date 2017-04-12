class Tweet
  attr_accessor :message, :username, :id

  DATABASE = DB[:conn]

  def self.all
    sql = <<-SQL
    SELECT * FROM tweets
    SQL
    results = DATABASE.execute(sql)
    # iterate over the results array
    results.collect do |tweet_info|
    # tweet_info  {'id' => 1, 'username' => 'coffeedad', 'message' => 'Great # coffee'}
    # for each hash, create a new instance of a Tweet
       Tweet.new(tweet_info)
    end
    # return a new array with those tweets inside
  end

  def initialize(options={})
    @message = options['message']
    @username = options['username']
    @id       = options['id']
  end

  def save
    ## Fire a sql statement to create a new tweet
    ## Should create a new tweet if it doesn't exist yet
    if persisted?
      # update the tweet instance in the table
      update_tweet_message_in_database
    else
      # self.id doesn't exist then insert new tweet into database
      insert_tweet_into_database
    end
  end

  def insert_tweet_into_database
    sql = <<-SQL
    INSERT INTO tweets (message, username)
    VALUES (?, ?)
    SQL
    DATABASE.execute(sql, self.message, self.username )

    last_row_sql = <<-SQL
    SELECT id FROM tweets
    ORDER BY id DESC
    LIMIT 1
    SQL
    @id = DATABASE.execute(last_row_sql).first['id']
    self
  end

  def update_tweet_message_in_database
    sql = <<-SQL
    UPDATE tweets SET message = (?) WHERE id = (?)
    SQL
    DATABASE.execute(sql, self.message, self.id)
  end


  def persisted?
    !!self.id
  end
end
