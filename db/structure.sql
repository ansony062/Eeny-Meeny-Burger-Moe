CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "last_name_kana" varchar, "first_name_kana" varchar, "last_name" varchar, "first_name" varchar, "nickname" varchar, "is_active" boolean, "default" true);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE TABLE IF NOT EXISTS "admins" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime);
CREATE UNIQUE INDEX "index_admins_on_email" ON "admins" ("email");
CREATE UNIQUE INDEX "index_admins_on_reset_password_token" ON "admins" ("reset_password_token");
CREATE TABLE IF NOT EXISTS "posts" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "image_id" integer NOT NULL, "name" varchar NOT NULL, "shop_name" varchar NOT NULL, "place" varchar NOT NULL, "review" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "comments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "post_id" integer NOT NULL, "post_comment" text NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "tags" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "name" varchar);
CREATE TABLE IF NOT EXISTS "post_tags" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "post_id" integer NOT NULL, "tag_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "favorites" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "post_id" integer NOT NULL, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "bookmarks" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "post_id" integer NOT NULL, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "relationships" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "follower_id" integer NOT NULL, "followed_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO "schema_migrations" (version) VALUES
('20231010032527'),
('20231010032746'),
('20231010032803'),
('20231010090746'),
('20231010091004'),
('20231010091019'),
('20231010091038'),
('20231010091052'),
('20231010091108'),
('20231010091156'),
('20231011194118'),
('20231011194200'),
('20231011194310'),
('20231011194709'),
('20231011195106'),
('20231011195249');


