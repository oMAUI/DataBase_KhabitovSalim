select ar.nickname, tr.track_name
from artists ar, tracks tr
where ar.nickname = 'miyagi' and ar.id = tr.artist_id