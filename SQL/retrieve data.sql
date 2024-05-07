---1
select  r.book_id, b.book_title, count(r.book_id) as jumlah from borrow as "br" left 
join requests  as "r" on br.request_id=r.request_id left join books as b on b.book_id=r.book_id group by r.book_id, b.book_title order by jumlah desc


---2
select bo.book_title,avg(r.return_date - b.borrow_date) as  average_diff from borrow as b join return as r on b.return_id=r.return_id
left join requests as re on re.request_id=b.request_id
left join books as bo on bo.book_id=re.book_id
group by bo.book_title order by average_diff desc


---3
select l.library_id,l.library_name, count(r.request_id) as count_request from requests as r join libraries as l on l.library_id=r.library_id  where r.request_status='Borrow' group by l.library_id,l.library_name order by count_request desc

---4
select u.user_id, u.name,  count(r.request_id) as count_request from requests as r left join users as u on r.user_id=u.user_id  where request_status='Borrow' group by u.user_id, u.name order by count_request desc



---5
select ba.library_id, b.book_id, b.book_title, b.author, ba.queue 
from books as b right join book_availability as ba on ba.book_id=b.book_id order by ba.queue desc
