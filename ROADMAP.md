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
games/:slug - show game
games/publishers/:slug - all games by publisher
games/consoles/:slug - all games on console
games/genres/:slug

while logged in as user
users/:user_slug/ - all games, links to:
users/:user_slug/publishers/:pub_slug to see all games from publisher user has
users/:user_slug/consoles/:con_slug to see all games for console user has
users/:user_slug/genres/:gen_slug to see all games in genre user has

put login page on home view, only display if logged in!
