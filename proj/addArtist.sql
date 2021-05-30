do $$
begin
if not exists(select ar.nickname from artists ar where ar.nickname = 'miyagi')
then
INSERT into artists(nickname)
values('miyagi');
end if;
end;
$$