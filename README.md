# Dijon

`/diʒɔ̃/`

```txt
Dijon; Docker Integration for Jitsi meet On debiaN
```

## Features

* User registration support via `users.csv` (via `prosodyctl register` command)
* SSL cert support (`data` directory)
* `robots.txt` support


## Requirements

* docker
* docker-compose


## Setup

Check files into `files` directory.  
And update `localhost` to your domain such as `meet.example.org`.

`default` configuration works as `anonymous` authentication.

```zsh
% git clone https://gitlab.com/grauwoelfchen/dijon.git
```

0. update files (host, domain and configuration)
1. put ssl.crt and ssl.key into data directory
2. set `{local|public}_address` in sip-communication.properties

```zsh
: users
% cp users.csv.sample users.csv
% $EDITOR users.csv

: files
% $EDITOR files/localhost.cfg.lua
% $EDITOR files/jitsi/meet/config.js
...
```


## Build

```zsh
% cd /path/to/dijon
% docker-compose up -d

: it works!
% curl -sL https://meet.example.org/
```


## Control

```zsh
% docker-compose {start|stop}
% docker-compose exec dijon /bin/bash

% docker stop dijon
% docker rm dijon
```


## Note

Replace blank ssl{crt,key} to generated self-signed files at postinstall of
jitsi-meet.

```zsh
% docker-compose exec dijon /bin/bash
# cp /etc/jitsi/meet/localhost.crt /jitsi-meet/data/ssl.crt
# cp /etc/jitsi/meet/localhost.key /jitsi-meet/data/ssl.key
# /etc/init.d/prosodyctl restart
# /etc/init.d/nginx restart
```


## License

Copyright (c) 2017 Yasuhiro Asaka

This is free software;  
You can redistribute it and/or modify it under the terms of
the Apache License License (`Apache-2.0`).

See `LICENSE`.
