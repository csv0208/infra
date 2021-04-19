#!/bin/bash

gcloud compute instances create reddit-app\
  --project=infra-310709 \
  --zone=europe-central2-a \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --metadata-from-file startup-script=startup_script.sh \
  --restart-on-failure

gcloud compute firewall-rules create "default-puma-server"\
  --allow=tcp:9292 \
  --target-tags="puma-server" \
  --source-ranges="0.0.0.0/0" \
  --description="default-puma-server-auto"
