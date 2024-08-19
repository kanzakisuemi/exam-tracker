# Acompanhamento Simples de Exames Médicos

Um projeto desenvolvido no Rebase Labs para o rastreamento e gerenciamento de exames médicos. Esta aplicação web permite a listagem e visualização de exames, com suporte para importação de dados e exibição de resultados de forma intuitiva.

### Funcionalidades

- **Importação de Dados:** Importa dados de exames a partir de arquivos CSV para um banco de dados SQL. Inclui uma ferramenta para importar os dados de forma assíncrona.
 ![Screenshot 2024-08-16 at 10 49 46](https://github.com/user-attachments/assets/db60ee2f-b572-496d-9d46-42245f5a7502)
- **Listagem de Exames:** Exibe uma lista de exames médicos em formato JSON e HTML.
 ![ScreenRecording2024-08-16at10 47 14-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/04edb6d1-4fa3-444f-b430-75e45057b58e)
- **Detalhamento de Exames:** Permite a visualização dos detalhes de um exame específico com base em um token único.
 ![Screenshot 2024-08-16 at 9 23 01](https://github.com/user-attachments/assets/df5216ad-99b4-4966-9200-ef49dbe963e8)
- **API e Web Interface:** Oferece endpoints para a importação de dados e visualização de exames.

### Tecnologias Utilizadas

- **Backend:** Ruby com Sinatra
- **Frontend:** HTML, CSS, JavaScript
- **Banco de Dados:** PostgreSQL
- **Containerização:** Docker
- **Processamento Assíncrono:** Sidekiq e Redis

### Setup e Execução
Esse projeto exige docker-compose para ser executado.
- **Configuração do Ambiente:** Para inicializar as apps (api e web), tanto quanto o banco de dados `docker-compose up`
- A app web pode ser acessada na porta 8888
- A app api pode ser acessada na porta 7777

### Endpoints da API

#### Acessar lista de Exames através do Token

- **Método:** `GET`
- **URL:** `/exams/:token`
- **Descrição:** Retorna um json com exames associados a um token.

**Requisição:**
```bash
get /exams/:token
```
**Resposta:**
```bash
{
  "result_token": "IQCZ17",
  "result_date": "2021-08-05",
  "cpf": "048.973.170-88",
  "name": "Emilly Batista Neto",
  "email": "gerald.crona@ebert-quigley.com",
  "birthday": "2001-03-11",
  "doctor":  {
    "crm": "B000BJ20J4",
    "crm_state": "PI",
    "name": "Maria Luiza Pires"
  },
  "exams": [
    {
      "type": "hemácias",
      "limits": "45-52",
      "result": "97"
    },
    {
      "type": "leucócitos",
      "limits": "9-61",
      "result": "89"
    },
    {
      "type": "plaquetas",
      "limits": "11-93",
      "result": "97"
    },
    {
      "type": "hdl",
      "limits": "19-75",
      "result": "0"
    },
    {
      "type": "ldl",
      "limits": "45-54",
      "result": "80"
    },
    {
      "type": "vldl",
      "limits": "48-72",
      "result": "82"
    },
    {
      "type": "glicemia",
      "limits": "25-83",
      "result": "98"
    },
    {
      "type": "tgo",
      "limits": "50-84",
      "result": "87"
    },
    {
      "type": "tgp",
      "limits": "38-63",
      "result": "9"
    },
    {
      "type": "eletrólitos",
      "limits": "2-68",
      "result": "85"
    },
    {
      "type": "tsh",
      "limits": "25-80",
      "result": "65"
    },
    {
      "type": "t4-livre",
      "limits": "34-60",
      "result": "94"
    },
    {
      "type": "ácido úrico",
      "limits": "15-61",
      "result": "2"
    }
  ]
}

```

#### Acessar Lista de Exames

- **Método:** `GET`
- **URL:** `/exams`
- **Descrição:** Retorna uma lista de exames em formato JSON.

**Requisição:**
```bash
get /exams
```
**Resposta:**
```bash
[
  {
    "result_token": "IQCZ17",
    "result_date": "2021-08-05",
    "cpf": "048.973.170-88",
    "name": "Emilly Batista Neto",
    "email": "gerald.crona@ebert-quigley.com",
    "birthday": "2001-03-11",
    "doctor": {
      "crm": "B000BJ20J4",
      "crm_state": "PI",
      "name": "Maria Luiza Pires"
    },
    "exams": [
      {
        "type": "hemácias",
        "limits": "45-52",
        "result": "97"
      },
      {
        "type": "leucócitos",
        "limits": "9-61",
        "result": "89"
      },
      {
        "type": "plaquetas",
        "limits": "11-93",
        "result": "97"
      },
      {
        "type": "hdl",
        "limits": "19-75",
        "result": "0"
      },
      {
        "type": "ldl",
        "limits": "45-54",
        "result": "80"
      },
      {
        "type": "vldl",
        "limits": "48-72",
        "result": "82"
      },
      {
        "type": "glicemia",
        "limits": "25-83",
        "result": "98"
      },
      {
        "type": "tgo",
        "limits": "50-84",
        "result": "87"
      },
      {
        "type": "tgp",
        "limits": "38-63",
        "result": "9"
      },
      {
        "type": "eletrólitos",
        "limits": "2-68",
        "result": "85"
      },
      {
        "type": "tsh",
        "limits": "25-80",
        "result": "65"
      },
      {
        "type": "t4-livre",
        "limits": "34-60",
        "result": "94"
      },
      {
        "type": "ácido úrico",
        "limits": "15-61",
        "result": "2"
      }
    ]
  },
  {
    "result_token": "ABC123",
    "result_date": "2022-01-15",
    "cpf": "123.456.789-00",
    "name": "João da Silva",
    "email": "joao.silva@example.com",
    "birthday": "1980-05-20",
    "doctor": {
      "crm": "A123CD45",
      "crm_state": "SP",
      "name": "Ana Souza"
    },
    "exams": [
      {
        "type": "hemácias",
        "limits": "40-50",
        "result": "45"
      },
      {
        "type": "leucócitos",
        "limits": "5-10",
        "result": "6"
      },
      {
        "type": "plaquetas",
        "limits": "150-450",
        "result": "200"
      },
      {
        "type": "hdl",
        "limits": "30-60",
        "result": "55"
      }
      // Outros exames
    ]
  }
]
```

#### Importar Dados

- **Método:** `POST`
- **URL:** `/import`
- **Descrição:** Importa dados de exames a partir de um arquivo CSV.

**Requisição:**

```bash
curl -X POST http://localhost:7777/import \
  -F 'csv_file=@caminho/para/seuarquivo.csv'
```

**Resposta:**

- **Código de Status 200 (OK):**

```json
{
  "message": "Arquivo recebido e processamento iniciado!"
}
```

- **Código de Status 400 (Bad Request):**

```json
{
  "message": "Nenhum arquivo enviado!"
}
```

### Testes

- **Testes de Unidade:** Para rodar os testes de unidade, use o comando:

```bash
docker-compose run --rm test-api
```

- **Testes de Integração:** Para rodar os testes de integração, use o comando:

```bash
docker-compose run --rm test-web
```

### About

Um projeto desenvolvido no Rebase Labs para o rastreamento e gerenciamento de exames médicos.
