#!/usr/bin/sh

ansible-inventory -i inventory.yml --list --export | tee inventory.json
