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
curl 162.19.66.30:5000/fragment -H 'Content-Type: application/json' -d '{"fragment":{"content":[{"path":{"folder":"fragment_1", "file":"main_content.txt"}, "type":"text", "file":"@./main_content.txt"}, {"path":{"folder":"fragment_1", "file":"illustration.png"}, "type":"img", "file":"@./illustration.png"}], "description":"une description","miniature":"./illus.svg", "title":"un titre"}}'

curl 162.19.66.30:5000/register -H 'Content-Type: application/json' -d '{"user":{"pseudo":"Squalli", "email":"test@test.com", "password":"mypass"}}'
```


