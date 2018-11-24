FROM ruby:2.5.3

WORKDIR /site

COPY Gemfile /site/

RUN bundle install

EXPOSE 4000

ENV LC_ALL "C.UTF-8"
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"

ENTRYPOINT [ "bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0" ]