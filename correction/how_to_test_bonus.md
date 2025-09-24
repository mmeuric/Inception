## Redis

Install Redis-cli on the host

`sudo apt-get install redis-tools`

Maket http request
redis-cli -h 127.0.0.1 -p 6379 ping

Respond must be : PONG

redis-cli -h 127.0.0.1 -p 6379 set testkey "Hello, Redis!"
redis-cli -h 127.0.0.1 -p 6379 get testkey