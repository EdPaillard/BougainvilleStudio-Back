FROM elixir:1.14.4

WORKDIR /serv
RUN mix local.hex --force && \
    mix local.rebar --force
COPY . ./
RUN mix deps.get && \
    mix deps.compile
EXPOSE 4000

ENTRYPOINT ["/bin/bash", "setup.sh"]