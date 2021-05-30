insert into track_comments(track_id, user_id, comment_date, comm)
values((select tr.id
from tracks tr
where tr.track_name = 'angel' and tr.artist_id = (select ar.id
from artists ar
where ar.nickname = 'miyagi')),
(select us.id
from users us
where us.login = 'user1' and us.pass = 'user1'),
current_timestamp,
'иииуууууууууу');