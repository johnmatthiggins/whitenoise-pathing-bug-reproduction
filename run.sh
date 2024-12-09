#!/usr/bin/env sh
export DJANGO_DEBUG="FALSE";
daphne whitenoise_bug.asgi:application
