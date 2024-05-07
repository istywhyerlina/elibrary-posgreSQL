---1
CREATE FUNCTION ck_quantity_avail(int,int) RETURNS integer
    AS $$ SELECT case when $1>=$2 then 1 else 0 end $$
    LANGUAGE SQL;

alter table book_availability
add constraint ck_quantity_avail
check (ck_quantity_avail (quantity_owned,quantity_available)  = 1)

---2
CREATE FUNCTION ck_request_date(int,date) RETURNS integer
    AS $$ SELECT case when $2>=(select date_created from users where user_id=$1 ) then 1 else 0 end $$
    LANGUAGE SQL;

alter table requests 
add constraint ck_request_date
check (ck_request_date (user_id,request_date)  = 1)

---3
CREATE FUNCTION ck_request_status(varchar) RETURNS integer
    AS $$ SELECT case when $1 in ('Borrow','Cancel','Borrow After Hold','Cancel After Hold','Return') then 1 else 0 end $$
    LANGUAGE SQL;

alter table requests 
add constraint ck_request_status
check (ck_request_status (request_status)  = 1)


---4
CREATE FUNCTION ck_finished_hold_1(date,date) RETURNS integer
    AS $$ SELECT case when $2>=$1 then 1 else 0 end $$
    LANGUAGE SQL;

alter table hold 
add constraint ck_finished_hold_1
check (ck_finished_hold_1 (start_hold,finished_hold)  = 1)


---5
CREATE FUNCTION ck_finished_hold_2(date,date,varchar) RETURNS integer
    AS $$ SELECT case when $3='Failed' and $2= ($1 + INTERVAL '7 day' ) then 1
 when $3!='Failed' then 1  else 0 end $$
    LANGUAGE SQL;

alter table hold 
add constraint ck_finished_hold_2
check (ck_finished_hold_2 (start_hold,finished_hold,hold_status)  = 1)


---6
CREATE FUNCTION ck_hold_status(varchar) RETURNS integer
    AS $$ SELECT case when $1 in ('On Hold', 'Borrowed','Canceled','Failed') then 1 else 0 end $$
    LANGUAGE SQL;

alter table hold 
add constraint ck_hold_status
check (ck_hold_status (hold_status)  = 1)


---7
CREATE FUNCTION ck_return_date(int,date) RETURNS integer
    AS $$ SELECT case when $1 is null then 1
When $1 is not null and $2<=(select return_date from return where return_id=$1 ) then 1 else 0 end $$
    LANGUAGE SQL;

alter table borrow 
add constraint ck_return_date
check (ck_return_date (return_id,borrow_date)  = 1)