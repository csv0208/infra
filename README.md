# infra

D5:
Подключение к bastion:

ssh -i ~/.ssh/appuser appuser@34.78.23.197

Подключение к internal:
ssh -i ~/.ssh/appuser -A -C appuser@34.78.23.197 -t ssh 10.132.0.3

devopscourses Infra repository
bastion_IP = 34.78.23.197
bastion_internsl_IP = 10.132.0.2
internal_IP = 10.132.0.3

pritunl
868c7ff6250e431f86465a6453b643af
mongodb://localhost:27017/pritunl

D6:
Деплой приложения:

создание VM:
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

создание firewall-rule:
gcloud compute firewall-rules create "default-puma-server"\
  --allow=tcp:9292 \
  --target-tags="puma-server" \
  --source-ranges="0.0.0.0/0" \
  --description="default-puma-server-auto"

