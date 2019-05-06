FROM alpine

CMD ["echo hello"]


COPY . /app
WORKDIR /app

#Execute Buildpack
RUN STACK=heroku-18 /tmp/buildpack/heroku/go/bin/compile /app /tmp/build_cache /tmp/env

# Prepare final, minimal image
FROM heroku/heroku:18

COPY --from=build /app /app
ENV HOME /app
WORKDIR /app
RUN useradd -m heroku
USER heroku
CMD /app/bin/mvc1
