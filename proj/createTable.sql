create table Artists(
id serial primary key,
nickName char(50) not null
);

create table Tracks(
id serial primary key,
track_name varchar(50) not null,
realase date,
track_text varchar(5000) not null,
artist_id int not null
);

create table users(
id serial primary key,
login varchar(255) not null,
pass varchar(255) not null
);

create table track_comments(
id serial primary key,
track_id int not null,
user_id int not null,
comment_date date not null,
comm varchar (2000) not null
);

create table about_text(
id serial primary key,
track_id int not null,
user_id int not null,
text_fragment varchar(255) not null,
comm varchar(1000) not null,
comm_date date not null
)
