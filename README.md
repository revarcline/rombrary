ROMBRARY
===

a lightweight Sinatra ROM library for classic consoles

## installation

to get up and running in a local environment, run the following in your terminal:

```bash
git clone https://github.com/revarcline/rombrary.git
cd rombrary
bundle install
rake db:migrate
rake db:seed
echo -e > .env "SESSION_SECRET=$(ruby -e "require 'sysrandom/securerandom'; puts SecureRandom.hex(64)")"
shotgun
```

from there, you simply need to send your browser to [localhost:9393](http://localhost:9393) to use the application.

to add an admin user, open `tux` from the project root directory, and set the `admin` attribute of your chosen `User` object to `true`

currently, rombrary is not recommended for production environments.

much love to [Corneal](https://github.com/thebrianemory/corneal) for helping create the initial framework.
