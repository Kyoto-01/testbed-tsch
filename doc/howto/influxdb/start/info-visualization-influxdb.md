# Visualização de informações do InfluxDB


## Fontes
* [Visualização de tokens](https://docs.influxdata.com/influxdb/v2.0/security/tokens/view-tokens/)

## 1. Visualização de perfis de configuração

```
influx config list
```

## 2. Visualização de tokens de API

Para executar algumas ações por meio da API InfluxDB HTTP, o usuário precisará informar o Token de API, criado durante o setup do InfluxDB.

### 2.1 Visualização de tokens de API pela GUI
* Acessar a URL ```http://<influxdb_server_ip>:8086```
* Fazer login
* Selecionar "Load Data-&gt;API Tokens" no menu à esquerda
* Será apresentada uma lista de tokens

### 2.2 Visualização de tokens de API pelo prompt de comando:
```
influx auth list
```

### 2.3 Visualização de tokens de API pela API do InfluxDB
```
GET /api/v2/authorizations
```


