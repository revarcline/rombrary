some stuff i ran into

I used corneal

which was good, but used activerecord 4.2

activerecord 4.2 uses some number stuff deprecated in ruby 6.1

upgrated activerecord to 5.2

needed to change `ActiveRecord::Migrations.needs_migration?` to `ActiveRecord::Base.connection.migration_context.needs_migration?`
