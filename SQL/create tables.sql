CREATE TABLE public. users
(
user_id int NOT NULL,
name varchar(50) NOT NULL,
email varchar(50) NOT NULL,
phone_number varchar(13) ,
date_created date NOT NULL NOT NULL,
CONSTRAINT pk_users PRIMARY KEY (user_id)
);


CREATE TABLE public. books
(
book_id int NOT NULL,
book_title varchar(200) NOT NULL,
author varchar(130) NOT NULL,
year_published int NOT NULL,
publisher varchar(100) NOT NULL,
ISBN varchar(50),
CONSTRAINT pk_books PRIMARY KEY (book_id)
);

CREATE TABLE public. libraries
(
library_id int NOT NULL,
library_name varchar(100) NOT NULL,
library_adress varchar(120),
CONSTRAINT pk_libraries PRIMARY KEY (library_id)
);


CREATE TABLE public. book_availability
(
ID int NOT NULL,
library_id int NOT NULL,
book_id int NOT NULL,
quantity_owned int NOT NULL,
quantity_available int NOT NULL,
queue int,
CONSTRAINT pk_book_availability PRIMARY KEY (ID),
CONSTRAINT fk_library FOREIGN KEY (library_id) REFERENCES public.libraries (library_id),
CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES public.books (book_id)
);

CREATE TABLE public. requests
(
request_id int NOT NULL,
user_id int NOT NULL,
library_id int NOT NULL,
book_id int NOT NULL,
request_date date NOT NULL,
request_status varchar(20) NOT NULL,
previous_request_to_excecute int REFERENCES public.requests (request_id),
CONSTRAINT pk_requests PRIMARY KEY (request_id),
CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users (user_id),
CONSTRAINT fk_library FOREIGN KEY (library_id) REFERENCES public.libraries (library_id),
CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES public.books (book_id));

CREATE TABLE public.queue
(
queue_id int NOT NULL,
request_id int NOT NULL,
is_queue_active boolean NOT NULL,
CONSTRAINT pk_queue PRIMARY KEY (queue_id),
CONSTRAINT fk_request FOREIGN KEY (request_id) REFERENCES public.requests (request_id)
);

CREATE TABLE public.hold
(
hold_id int NOT NULL,
queue_id int NOT NULL,
request_id_after_hold int ,
start_hold date NOT NULL,
finished_hold date ,
hold_status varchar(8) NOT NULL,
CONSTRAINT pk_hold PRIMARY KEY (hold_id),
CONSTRAINT fk_queue FOREIGN KEY (queue_id) REFERENCES public.queue (queue_id),
CONSTRAINT fk_request_id_after_hold FOREIGN KEY (request_id_after_hold) REFERENCES public.requests (request_id)
);


CREATE TABLE public.return
(
return_id int NOT NULL,
return_date date NOT NULL,
is_automatic boolean ,
CONSTRAINT pk_returm PRIMARY KEY (return_id));

CREATE TABLE public.borrow
(
borrow_id int NOT NULL,
request_id int NOT NULL,
hold_id int ,
borrow_date date NOT NULL,
return_id int ,
CONSTRAINT pk_borrow PRIMARY KEY (borrow_id),
CONSTRAINT fk_request FOREIGN KEY (request_id) REFERENCES public.requests (request_id),
CONSTRAINT fk_hold FOREIGN KEY (hold_id) REFERENCES public.hold (hold_id),
CONSTRAINT fk_return FOREIGN KEY (return_id) REFERENCES public.return (return_id) deferrable initially deferred
);