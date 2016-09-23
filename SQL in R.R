# The easiest way is to connect to database with R, send query and fetch the result

# Load required package
stopifnot(require(RMySQL))

# Establish connection to database
db <- dbConnect(MySQL(), user = USERNAME, password = PASSWORD, dbname = message_center, host = HOST_IP)

# Query to get the sender ID and conversation ID for messages related to returning an item from the message center database
raw_messages <- dbGetQuery(db,
                         "SELECT id AS 'sender_id',
                          conversation_id AS 'convo_id'
                          FROM conversation AS cv
                          RIGHT JOIN message AS ms
                          ON cv.convo_id = ms.convo_id 
                          WHERE (ms.text_body LIKE '%how to return'
                          OR ms.text_body REGEXP 'return')
                          AND YEAR(ms.sent_date) = 2016
                          ORDER BY ms.sent_date
                          ;")

# Result is a dataframe in R