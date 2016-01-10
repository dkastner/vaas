FROM ruby:2.2.4

WORKDIR /vaas

RUN gem install puma -v 2.15.3
RUN gem install sinatra -v 1.4.6
RUN gem install vcr -v 3.0.1

ADD app /vaas/app
ADD lib /vaas/lib
ADD config.ru /vaas/config.ru

EXPOSE 80

CMD puma config.ru -p 80
