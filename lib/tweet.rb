class Tweet
  attr_accessor :message, :username
  attr_reader :id

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

  def persisted?
    !!self.id
  end
end
