select tr.track_name, tr.id, (select ar.nickname
from artists ar
where ar.id = tr.artist_id)
from tracks tr
where tr.track_name = 'angel'
order by nickname