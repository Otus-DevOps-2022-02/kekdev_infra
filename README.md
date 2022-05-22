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
Конфиг разбит на модули, а также на 2 конфигурации для стейджинг и прод сред
В качестве бэкэнда для стейта используется s3

В директории нужной среды конфигурации:
1. Копируем `s3.tfbackend.example` в `s3.tfbackend`
2. Заполняем актуальными данными в `s3.tfbackend`
3. Выолняем `terraform init -backend-config=s3.tfbackend`
4. Копируем `terraform.tfvars.example` в `terraform.tfvars`
5. Заполняем актуальными данными в `terraform.tfvars`
6. Запускает `terraform apply`

### Ansible 1 ###
Установлен ansible на локальной машине
Добавлены файл конфигурации и инвентаря

Добавлен плейбук `clone.yml`
При первом выполении, ansible показывает, что никаких изменений не производилось,
т.к. директория `reddit` с кодом уже существует
После выполнения команды `ansible app -m command -a 'rm -rf ~/reddit'` и повторном выполнении плейбука,
ansible повторно клонирует репозиторий и в результате показывает, что было изменение

**
В качестве динамического inventory используем баш скрипт, который просто считывает рядом лежащий json

### Ansible 2 ###
Добавлен playbook'и:
1. с одним сценарием
2. с множественными сценариями
3. несколько плейбуков

Обновлены конфиги packer для создание образов с помощью провизионеров ansible

* Доавлен динамический инвентарь yc compute с помощью плагина инвентаря

### Ansible 3 ###
Плейбук разбит на роли
Добавлены настройки для разных окружений
Плейбуки перенесены в отдельную директорию
Использована роль из ansible galaxy
Добавлен зашифрованные средством ansible vault файлы

### Ansible 4 ###
Установлены vagrant и virtualbox, добавлена в зависимости пакет molecule
Добавлены тесты для роли db
Внесены правки в плейбуки и конфигурации packer для использования ролей
