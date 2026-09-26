# KitShelf

The landing page of https://kitshelf.app: one static `index.html` (fonts embedded, no scripts, no build step)
that introduces the kits. Each kit lives in its own repository on its own subdomain; TripKit is `quiz-trip`,
served at https://trip.kitshelf.app.

## Deployment

GitHub Pages publishes the `docs/` folder of `main` as it is (**Settings → Pages → Deploy from a branch → main
/docs**); nothing outside `docs/` reaches the site. `docs/CNAME` holds the custom domain and `docs/.nojekyll` switches
Jekyll off, so the files are served untouched.

DNS is in Cloudflare, every record *DNS only*: four `A` and four `AAAA` records on `@` pointing at GitHub Pages,
and a `CNAME` from `www` to `<user>.github.io`, which GitHub redirects to the apex. Mail to
`merhaba@kitshelf.app` is forwarded by Cloudflare Email Routing.
