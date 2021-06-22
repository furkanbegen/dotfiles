#!/bin/sh

scrot -s -e 'mv $f /tmp/ && gimp /tmp/$f'
