# seed data!
## regions
us = Region.create(name: 'US')
jp = Region.create(name: 'JP')
eu = Region.create(name: 'EU')
hack = Region.create(name: 'HACK')

## consoles
snes = Console.create(name: 'SNES')
nes = Console.create(name: 'NES')
gba = Console.create(name: 'GBA')
gbc = Console.create(name: 'GBC')
psx = Console.create(name: 'PSX')
gen = Console.create(name: 'Genesis')

## publishers
konami = Publisher.create(name: 'Konami')
nintendo = Publisher.create(name: 'Nintendo')
capcom = Publisher.create(name: 'Capcom')
sega = Publisher.create(name: 'Sega')
takemoto = Publisher.create(name: 'T. Takemoto')

## genres
platform = Genre.create(name: 'Platformer')
action = Genre.create(name: 'Action')
stealth = Genre.create(name: 'Stealth')
rpg = Genre.create(name: 'RPG')
fighting = Genre.create(name: 'Fighting')

## users
alex = User.create(username: 'revarcline',
                   admin: true,
                   email: 'alex@fake.com',
                   password: 'stinker')

bulb = User.create(username: 'bulbasaur',
                   email: 'bulb@fake.com',
                   password: 'stinker')

char = User.create(username: 'charmander',
                   email: 'char@fake.com',
                   password: 'stinker')

## games
mario = Game.create(name: 'Super Mario Bros',
                    year: 1985,
                    genres: [action, platform],
                    regions: [jp],
                    console: nes,
                    publishers: [nintendo])

sonic = Game.create(name: 'Sonic the Hedgehog 2',
                    year: 1992,
                    genres: [action, platform],
                    regions: [us],
                    console: gen,
                    publishers: [sega])

zelda_seasons = Game.create(name: 'Legend of Zelda: Oracle of Seasons',
                            year: 2001,
                            genres: [action, rpg],
                            regions: [eu],
                            console: gbc,
                            publishers: [nintendo, capcom])

kaizo = Game.create(name: 'Kaizo Mario World',
                    year: 2007,
                    regions: [jp, hack],
                    genres: [action, platform],
                    console: snes,
                    publishers: [nintendo, takemoto])

castlevania = Game.create(name: 'Castlevania: Aria of Sorrow',
                          year: 2003,
                          regions: [eu],
                          genres: [action, platform, rpg],
                          console: gba,
                          publishers: [konami])

street_fighter = Game.create(name: 'Street Fighter II',
                             year: 1992,
                             regions: [us],
                             genres: [fighting],
                             console: snes,
                             publishers: [capcom])

mgs = Game.create(name: 'Metal Gear Solid',
                  year: 1998,
                  regions: [eu],
                  genres: [stealth, action],
                  console: psx,
                  publishers: [konami])

## users
alex.update(games: [mgs, castlevania, kaizo, zelda_seasons])
bulb.update(games: [street_fighter, mario, sonic])
char.update(games: [sonic, kaizo, mgs, mario])

mario.created_by = bulb
sonic.created_by = char
kaizo.created_by = char
castlevania.created_by = alex
street_fighter.created_by = bulb
mgs.created_by = alex
zelda_seasons.created_by = alex
