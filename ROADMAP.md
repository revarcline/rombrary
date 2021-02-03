UPCOMING
===

so, let's talk structure/models/etc
gonna be lots of joins!

## models
User
- has_many games through user_games
string - username
string - email
string - password_digest
slugable

Game
- has_many users through user_games
- has_many genres through game_genres
- belongs_to console
- belongs_to publisher
string - name
integer - console_id
integer - publisher_id
slugable

Genre
- has_many games through game_genres
string - name
slugable

Publisher
- has_many games
string - name
slugable

Console
- has_many games
string - name
slugable

UserGames
- has_many games
- has_many users

GameGenres
- has_many games
- has_many genres

----
just added regions and game regions, similar to genre

* need to handle multi-console releases... maybe always present as (game)(console) when not sorted by console since they're different files after all


have option to look through (search?) all games, present as suggested above
each game page has "add to library" button if logged in

if game not available, add new game through form
form like:
game name

game publisher (dropdown, incl "other" at end)
new game publisher

if user has game in library, any logged_in user can edit entry (cannot delete, but can remove from list!)

## views
logged out can view all games, possibly offer different sorting methods for game views and controller
make publisher, console, and genre slugable
like
for anyone:
games/:id - show game
(while logged in)
- other users with game,


games/ - all games
publishers/:slug - all games by publisher
consoles/:slug - all games on console
genres/:slug
regions/:slug

so :attr/:slug
make use of send(params[:attr])

do in game controller
possibly use a slug send function to simplify!
same with edit

while logged in as user
users/:slug - all user games

do in user controller as above

put login page on home view, only dhttps://twitter.com/dhxrin/status/1356296135879479302isplay if logged in!


if game in no libraries, can be deleted by logged in user
(check against user_games)

similarly, if genre/publisher/console/region is unused, can be deleted by logged in user


ORRRRR
after getting this working, add admin!
(no)
also: game-new should only be available AFTER a search, to prevent duplicate entries

search needs to use uri-encode

games/find?=:term
params[term]
https://github.com/mezis/fuzzily

adding created_by as an integer, make helper method my_post? which checks against current user id
more activerecord way is to add a boolean to the join

model method created_by=(user)

user_games where (user) and game = self

shadow init
attr_reader for created_by (wrong! all are custom defined)

ok the code is in the model, this was a better way to do it! likely blog post fodder.
i will have to see how well it works first though

possibly add logic to remove a category when it is unused

ask about security and using eval for my case statement

create delete if unused module after delete in place - call "destroy_orphans"
maybe helper method to iterate through all classes


OK SO delete method (hidden form? idek) is borked, go to office hours




CURRENT CRISIS:
cannot seem to delete associations in many-to-many
furthermore Game.update creates new instance
are join tables read only? (this seems fixed)

it appears my edit form is not working as a patch

maybe create an admin view? yes, where you can run automated orphan collection and delete params

ok add admin then
(pretty painless)
(it works except for patch/delete requests still being borked)
