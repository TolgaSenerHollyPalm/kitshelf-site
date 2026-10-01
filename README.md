# KitShelf

The landing page of https://kitshelf.app: one static `index.html` (fonts embedded, no build step; its only script
is the Cloudflare visit counter) that introduces the kits. Each kit lives in its own repository on its own
subdomain: TripKit is `quiz-trip`, served at https://trip.kitshelf.app, BookKit is `bookkit`, served at
https://book.kitshelf.app, and FreedomKit is `freedomkit`, served at https://freedom.kitshelf.app.

## Deployment

GitHub Pages publishes the `docs/` folder of `main` as it is (**Settings → Pages → Deploy from a branch → main
/docs**); nothing outside `docs/` reaches the site. `docs/CNAME` holds the custom domain and `docs/.nojekyll` switches
Jekyll off, so the files are served untouched.

DNS is in Cloudflare, every record *DNS only*: four `A` and four `AAAA` records on `@` pointing at GitHub Pages,
and a `CNAME` from `www` to `<user>.github.io`, which GitHub redirects to the apex. Mail to
`merhaba@kitshelf.app` is forwarded by Cloudflare Email Routing.

## Link preview

`docs/og.png` is the 1200×630 image that WhatsApp, iMessage and social sites show for a shared link. Its source is
`og/og.html`, the page's shelf drawing on a full-width shelf; after changing it, or when a kit goes from *Yakında*
to *Yayında*, run `og/render.sh` (headless Chrome, with the fonts embedded in `docs/index.html`) and commit the new
PNG. Link previews are cached, so a changed image can take a while to show up in chats.
