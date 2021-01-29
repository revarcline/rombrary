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
psx = Console.create(name: 'PSX')
gen = Console.create(name: 'Genesis')

## publishers
konami = Publisher.create(name: 'Konami')
nintendo = Publisher.create(name: 'Nintendo')
capcom = Publisher.create(name: 'Capcom')
sega = Publisher.create(name: 'Sega')

## genres
platform = Genre.create(name: 'Platformer')
action = Genre.create(name: 'Action')
stealth = Genre.create(name: 'Stealth')
rpg = Genre.create(name: 'RPG')
fighting = Genre.create(name: 'Fighting')

## games
mario = Game.create(name: 'Super Mario Bros',
                    year: 1985,
                    genres: [action, platform],
                    regions: [jp],
                    console: nes,
                    publisher: nintendo)

sonic = Game.create(name: 'Sonic the Hedgehog 2',
                    year: 1992,
                    genres: [action, platform],
                    regions: [us],
                    console: gen,
                    publisher: sega)

kaizo = Game.create(name: 'Kaizo Mario World',
                    year: 2007,
                    regions: [jp, hack],
                    genres: [action, platform],
                    console: snes,
                    publisher: nintendo)

castlevania = Game.create(name: 'Castlevania: Aria of Sorrow',
                          year: 2003,
                          regions: [eu],
                          genres: [action, platform, rpg],
                          console: gba,
                          publisher: konami)

street_fighter = Game.create(name: 'Street Fighter II',
                             year: 1992,
                             regions: [us],
                             genres: [fighting],
                             console: snes,
                             publisher: capcom)

mgs = Game.create(name: 'Metal Gear Solid',
                  year: 1998,
                  regions: [eu],
                  genres: [stealth, action],
                  console: psx,
                  publisher: konami)

## users
User.create(username: 'revarcline',
            email: 'alex@fake.com',
            games: [mgs, castlevania, kaizo],
            password: 'stinker')

User.create(username: 'bulbasaur',
            email: 'bulb@fake.com',
            games: [street_fighter, mario, sonic],
            password: 'stinker')

User.create(username: 'charmander',
            email: 'char@fake.com',
            games: [sonic, kaizo, mgs, mario],
            password: 'stinker')
