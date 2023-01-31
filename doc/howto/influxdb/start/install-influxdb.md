# Instalando o InfluxDB v2.6.1


## Fontes
[Instalação do InfluxDB](https://docs.influxdata.com/influxdb/v2.0/install/?t=Linux)

<br>

## Adicionar chaves de assinatura dos repositórios

```
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
```
```
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
```

<br>

## Adicionar listas de repositórios

```
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
```

<br>

## Atualizar lista de repositórios e instalar o InfluxDB

```
sudo apt-get update && sudo apt-get install influxdb2
```

<br>

## Iniciar o influxDB

```
sudo systemctl start influxd
```

<br>

## Verificar se o InfluxDB iniciou

```
sudo systemctl status influxd
```

<br>

Obs.: O influxDb, por padrão, irá usar a porta TCP 8086 para se comunicar com o cliente por meio da API InfluxDB HTTP.

