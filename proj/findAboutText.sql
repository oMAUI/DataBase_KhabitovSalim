select abt.text_fragment, abt.comm, abt.comm_date, (select us.login
from users us
where abt.user_id = us.id)
from about_text abt
where (select tr.id
from tracks tr
where tr.track_name = 'angel' and (select ar.id
from artists ar
where ar.nickname = 'miyagi') = tr.artist_id) = abt.track_id