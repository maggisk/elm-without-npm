FROM debian:buster-slim

WORKDIR "/app"

ENV ELM_VERSION=0.19.1 \
    ELM_FORMAT_VERSION=0.8.2 \
    MODD_VERSION=0.8 \
    DEVD_VERSION=0.9 \
    ESBUILD_VERSION=0.0.9 \
    SASS_VERSION=1.26.1

# install dependencies
RUN apt update && apt install -y curl && apt clean

# Elm: https://elm-lang.org
RUN curl -L "https://github.com/elm/compiler/releases/download/$ELM_VERSION/binary-for-linux-64-bit.gz" \
    | gunzip > /usr/local/bin/elm \
    && chmod +x /usr/local/bin/elm

# elm-format: https://github.com/avh4/elm-format
RUN curl -L "https://github.com/avh4/elm-format/releases/download/$ELM_FORMAT_VERSION/elm-format-$ELM_FORMAT_VERSION-linux-x64.tgz" \
    | tar xzO > /usr/local/bin/elm-format \
    && chmod +x /usr/local/bin/elm-format

# modd: https://github.com/cortesi/modd
RUN curl -L "https://github.com/cortesi/modd/releases/download/v$MODD_VERSION/modd-$MODD_VERSION-linux64.tgz" \
    | tar -xzO > /usr/local/bin/modd \
    && chmod +x /usr/local/bin/modd

# devd: https://github.com/cortesi/devd
RUN curl -L "https://github.com/cortesi/devd/releases/download/v$DEVD_VERSION/devd-$DEVD_VERSION-linux64.tgz" \
    | tar xzO > /usr/local/bin/devd \
    && chmod +x /usr/local/bin/devd

# esbuild: https://github.com/evanw/esbuild
RUN curl -L "https://registry.npmjs.org/esbuild-linux-64/-/esbuild-linux-64-$ESBUILD_VERSION.tgz" \
    | tar xzO > /usr/local/bin/esbuild \
    && chmod +x /usr/local/bin/esbuild

# sass (dart version (the best version)): https://sass-lang.com/
RUN cd / \
    && curl -L "https://github.com/sass/dart-sass/releases/download/$SASS_VERSION/dart-sass-$SASS_VERSION-linux-x64.tar.gz" \
    | tar xz \
    && ln -s /dart-sass/sass /usr/local/bin/sass

CMD ["modd"]
