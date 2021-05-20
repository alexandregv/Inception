# Redis

### Cache store

Redis is used as the cache store of WordPress. Its data is not persisted since it is only cache, holding user sessions and stuff like that.

It only uses the `redis` network to communicate with WordPress.

There is no environment variables for Redis, because it has no authentication (it's safe since it's not exposed).

The installation and configuration is made on build.
