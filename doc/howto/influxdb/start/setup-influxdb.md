# Configurações iniciais do InfluxDB


## Fontes
* [Configurações iniciais](https://docs.influxdata.com/influxdb/v2.0/install/?t=CLI+Setup)
* [Visualização de tokens](https://docs.influxdata.com/influxdb/v2.0/security/tokens/view-tokens/)
* [Visualização de tokens pela linha de comando](https://docs.influxdata.com/influxdb/v2.0/security/tokens/view-tokens/)

<br>

## Setup

```
influx setup
```

* Depois, basta preencher o que se pede.
* Após o preenchimento das opções, o InfluxDB criará um usuário inicial e um perfil de configuração.

<br>

## Visialização de perfis de configuração

```
influx config list
```

<br>

## Visualização de tokens de API

Para a execução de algumas ações no terminal, o usuário precisará informar o Token de API, também criado durante o setup. Há três formas de visualizar tal informação:

* Pela interface gráfica:
	* Acessar a URL &lt;endereco-do-servidor-influxdb&gt;:8086
	* Fazer login
	* No menu à esquerda selecione "Load Data-&gt;API Tokens"
	* Será apresentada uma lista de tokens

* Pelo prompt de comando:
```
influx auth list
```

* Pela API do InfluxDB
	* GET /api/v2/authorizations


