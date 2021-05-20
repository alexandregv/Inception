# Minisite

### Mini demo site + slides

A really simple static website using a Go backend and some slides written with [Slidev](https://sli.dev). Wait... Aren't we inside this right now? Is this Inception?
I wanted two different tools to show off Docker Multi Stage Builds, which consists of using multiple stages in our Dockerfile to compile our applicatio**s**, and then create the final stage.
Check it in `minisite/Dockerfile` if you are curious! (Actually you are kind of supposed to check it, if you are my evaluator)

It uses the `nginx` network to be `proxy_pass`'d and has no volume since it's a static site.

The only environment variable is `SLIDEV_BASE`, which allows to change the slides base path (i.e `/minisite/slides`).

The Go application is built on buildtime, as well as the slides (but in a different stage!), and then we just copy the static assets to the final stage.
The runtime only starts the Go app and serves these static assets.
