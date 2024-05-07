COPY users(user_id,name,email,phone_number,date_created)
FROM 'C:\Users\Public\Documents\Week 8\users_library.csv'
DELIMITER ','
CSV HEADER;

COPY books(book_ID,book_title,author,year_published,publisher,ISBN)
FROM 'C:\Users\Public\Documents\Week 8\books.csv'
DELIMITER ','
CSV HEADER;

COPY libraries(library_id,library_name,library_adress
)
FROM 'C:\Users\Public\Documents\Week 8\libraries.csv'
DELIMITER ','
CSV HEADER;

COPY book_availability (ID,library_id,book_id,quantity_owned,quantity_available,queue
)
FROM 'C:\Users\Public\Documents\Week 8\bookavailability.csv'
DELIMITER ','
CSV HEADER;

COPY requests(request_id,user_id, library_id,book_id,request_date,request_status,previous_request_to_excecute
)
FROM 'C:\Users\Public\Documents\Week 8\requests.csv'
DELIMITER ','
CSV HEADER;

COPY queue(queue_id,
request_id,
is_queue_active
)
FROM 'C:\Users\Public\Documents\Week 8\queue.csv'
DELIMITER ','
CSV HEADER;

COPY hold(hold_id,
queue_id,
Request_id_after_hold,
start_hold,
finished_hold,
hold_status
)
FROM 'C:\Users\Public\Documents\Week 8\hold.csv'
DELIMITER ','
CSV HEADER;

COPY return(return_id,
return_date,
is_automatic
)
FROM 'C:\Users\Public\Documents\Week 8\return.csv'
DELIMITER ','
CSV HEADER;

COPY borrow(borrow_id,
request_id,
hold_id,
borrow_date,
return_id
)
FROM 'C:\Users\Public\Documents\Week 8\borrow.csv'
DELIMITER ','
CSV HEADER;