select tc.comment_date, tc.comm, (select us.login
from users us
where tc.user_id = us.id)
from track_comments tc
where (select tr.id
from tracks tr
where tr.track_name = 'angel' and (select ar.id
from artists ar
where ar.nickname = 'miyagi') = tr.artist_id) = tc.track_id
order by tc.comment_date