# Command center

Command center is a simple web application which can execute console command via web.
This program can be useful to control local virtual machine. Customize the front page and make life easier.

## Screenshot

![screenshot](/docs/screenshot.png?raw=true)

## Prerequisites

This program depends on ruby and related gems.

If you are running ubuntu 14.04, you can install them by following commands.
(ruby is already included in ubuntu)

```bash
$ sudo apt-get update
$ sudo apt-get install -y ruby1.9.1-dev libssl-dev
$ sudo gem install bundler
```

## Install

```
$ bundle install
```

## Run

```bash
$ ruby main.rb
```

Open your browser and connect to http://localhost:3030.

## Customize commands

Add or modify .yml files in bookmark directory.

```YAML
- name: dmesg
  command: dmesg
- name: syslog
  command: sudo tail -50 /var/log/syslog
```

There can be a keyword surrounded by `{{` and `}}` mark in a command.
Then instead of being executed immediately, the command is displayed and the keyword is selected.

```YAML
- name: commit
  command: git commit -a -m "{{message}}"
```

## Sample upstart script for vagrant

```
description "command center"
author "essem"

start on vagrant-mounted
stop on shutdown

script
        cd /vagrant/command_center/
        exec /usr/bin/ruby main.rb
end script
```
