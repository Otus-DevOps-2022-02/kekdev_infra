# kekdev_infra
kekdev Infra repository

### Полключение к someinternalhost ###
Для подключения в одну команду необходимо указать `jump host` через опцию `-J`

`ssh -A -J appuser@<just_host> appuser@someinternalhost`

Чтобы подключаться к хосту по алиасу необходимо добавить конфиг SSH (`~/.ssh/config`):

`
Host someinternalhost
  HostName <internal_host_ip>
  IdentityFile <private_key>
  ProxyJump appuser@<jump_host>
  User appuser
`
