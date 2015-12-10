#!/usr/bin/env bash

cd /vagrant
gem install pg -- --with-pg-config=/usr/pgsql-9.2/bin/pg_config
bundle install
