# Instalação do InfluxDB v2.6.1

## Fontes
* [Instalação do InfluxDB](https://docs.influxdata.com/influxdb/v2.0/install/?t=Linux)

## 1. Instalação

### 1.1 Instalar ferramentas necessárias

```
sudo apt update && sudo apt install -y gpg
```

### 1.2 Adicionar chaves de assinatura dos repositórios

```
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
```

```
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
```

### 1.3 Adicionar listas de repositórios

```
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
```

### 1.4 Atualizar lista de repositórios e instalar o InfluxDB

```
sudo apt update && sudo apt install influxdb2
```

## 2. Inicialização

### 2.1 Iniciar o influxDB

```
sudo systemctl start influxd
```

### 2.2 Verificar se o InfluxDB foi inicializado com sucesso

```
sudo systemctl status influxd
```

## 3. Configurações iniciais

```
influx setup
```

Após o preenchimento das opções, o InfluxDB criará um usuário inicial e um perfil de configuração.

## 4. GUI InfluxDB

Para acessar a GUI do InfluxDB atavés de um navegador basta digitar a URl ```http://<influxdb_server_ip>:8086```.

---

**_Obs.:_** O influxDB, por padrão, irá usar a porta TCP 8086 para se comunicar com o cliente por meio da API InfluxDB HTTP.

---
