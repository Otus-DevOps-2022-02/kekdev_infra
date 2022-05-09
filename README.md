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

### Reddit app image ###
1. Создаём сервис-аккаунт в `yc` и присваиваем ему роль `editor`
2. Создаём ключ для сервис-аккаунта
3. Создаём базовый образ с помощью `packer` с предустановленными `ruby` и `mongodb`
4. Поднимаем ВМ на основе нашего образа
5. Внутри ВМ устанавливаем и запускаем наше приложение
```
sudo apt-get update
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
```
51.250.82.153
### Terraform app install ###
1. Копируем `terraform.tfvars.example` в `terraform.tfvars`
2. Заполняем актуальными данными в `terraform.tfvars`
3. Запускает `terraform apply`

Добавлен лоад балансер, для запуска нескольких инстансов приложения
Чтобы уменьшить дублирование кода, для поднятия нескольких инстансов приложения,
использован ключ `count` для ресурса `yandex_compute_instance`
