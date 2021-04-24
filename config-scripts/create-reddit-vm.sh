#!/bin/bash

gcloud compute instances create reddit-app\
  --image=reddit-full-1619264286 \
  --zone=europe-west1-b \
  --tags puma-server \
  --restart-on-failure
