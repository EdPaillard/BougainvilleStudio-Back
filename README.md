# BougBack

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


# API
```bash
curl 162.19.66.30:5000/fragment -H 'Content-Type: application/json' -d '{"fragment":{"content":[{"path":"fragment_8/easyrider.mp4", "type":"video"}], "description":"Un personnage enigmatique traverse le désert dans la tempête sur son rider.","miniature":"fragment_8/easyrider.png", "title":"Easyrider"}}'

curl 162.19.66.30:5000/register -H 'Content-Type: application/json' -d '{"user":{"pseudo":"Squalli", "email":"test@test.com", "password":"mypass"}}'
```
``` bash
curl 162.19.66.30:5000/fragment -H 'Content-Type: application/json' -d '{"fragment":{"content":[{"path":{"folder":"fragment_17", "file":"ecclemosie.docx"}}, "type":"text", "file":"@./ecclemosie.docx"]}, "description":"Hautbrave se retrouve au milieu d\'événements chaotiques sur une planète lointaine", "miniature":"fragment_17/ecclemosie.png", "titre": "Ecclemosie"}}'
```

localhost:4000/miniature -H 'Content-Type: multipart/form-data' -F "miniature=@hb_darkness.png" -F "id=5"