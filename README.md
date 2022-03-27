# kekdev_infra
kekdev Infra repository

### Полключение к someinternalhost ###
Для подключения в одну команду необходимо указать `jump host` через опцию `-J`

`ssh -A -J appuser@<just_host> appuser@someinternalhost`

Чтобы подключаться к хосту по алиасу необходимо добавить конфиг SSH (`~/.ssh/config`):

```
Host someinternalhost
  HostName <internal_host_ip>
  IdentityFile <private_key>
  ProxyJump appuser@<jump_host>
  User appuser
```

### SSL Сертификат ###
Для получения сертификата достаточно прописать в настройках
в веб-консоли домен `<ip>.sslip.io`

### Данные для подключения по VPN ###
```
bastion_IP = 51.250.7.149
someinternalhost_IP = 10.128.0.32
```

### Test App ###
```
testapp_IP = 51.250.65.138
testapp_port = 9292
```

### App create CLI command ###
```
yc compute instance create --name reddit-app --hostname reddit-app --memory=4 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
    --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
    --metadata serial-port-enable=1 --metadata-from-file user-data=./startup-script.sh
```
