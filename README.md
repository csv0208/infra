# infra

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

