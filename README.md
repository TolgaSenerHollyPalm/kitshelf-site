# KitShelf

The landing page of https://kitshelf.app: one static `index.html` (fonts embedded, no build step) that introduces
the kits. Besides the Cloudflare visit counter it has two short inline scripts for the cards' "Neler yapar?" button;
without JavaScript every card simply shows its list. Each kit lives in its own repository on its own
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

`docs/og.png` is the 1200×630 image that WhatsApp, iMessage and social sites show for a shared link. It is made on
the design canvas ("KitShelf Tanıtım Sayfası" in Claude Design, the OgImage frame) and committed as it is.
`og:image` asks for `og.png?v=N`: link previews are cached by address, so every new image raises `N` by one.

## Adding a kit

The next kit, FreeTimeKit, goes live with these steps:

1. **Card:** copy a card. The kit's colours get a class `.kit-x { --kit: …; --kit-dark: … }`; the tick circle and the
   tick take the kit's light and dark tones. A live kit gets the "{Kit}'i aç" link with its `long`/`short` labels and
   `aria-label`; a kit not yet live keeps the "Yakında rafta" pattern. `aria-controls` and the list's `id` are the
   kit's own (`checks-x`).
2. **Shelf:** a kit going live puts its icon on the bookcase before the "Sıradaki kit" place and gets a plate; a
   coming kit stands in `.case-soon` with its badge. A shelf (`.case-row`) has three places; when it is full, add a
   new `.case-row`. "Sıradaki kit" always stays at the end of the last shelf, and the case grows by itself.
3. **Heading:** "Üç kit yayında," turns into the number of live kits.
4. **Footer:** a link to the kit's address.
5. **Link preview:** when the shelf changes, take a new `og.png` from the design canvas and raise `?v=` by one.
