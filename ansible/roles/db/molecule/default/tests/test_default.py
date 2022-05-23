def test_mongo_running_and_enabled(host):
    mongo = host.service("mongod")
    assert mongo.is_running
    assert mongo.is_enabled

def test_config_file(host):
    config_file = host.file('/etc/mongod.conf')
    assert config_file.contains('bindIp: 0.0.0.0')
    assert config_file.is_file

def test_mongo_listen_port(host):
    assert host.socket("tcp://0.0.0.0:27017").is_listening
