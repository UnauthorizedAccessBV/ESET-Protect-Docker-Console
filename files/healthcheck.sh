#!/bin/sh

curl http://127.0.0.1:8080/era/webconsole/ | grep '<title>ESET PROTECT on-prem</title>' || exit 1
