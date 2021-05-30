insert into about_text(track_id, user_id, text_fragment, comm, comm_date)
values((select tr.id
from tracks tr
where tr.track_name = 'angel' and tr.artist_id = (select ar.id
from artists ar
where ar.nickname = 'miyagi')),
(select us.id
from users us
where us.login = 'user1' and us.pass = 'user1'),
'самурай',
'самурай - в переводе означает служить',
current_timestamp);