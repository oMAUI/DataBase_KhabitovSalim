do $$
begin
if not exists(select us.login from users us where us.login = 'user12')
then
INSERT into users(login, pass)
values('user12', 'user1');
end if;
end;
$$