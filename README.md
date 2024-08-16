# Acompanhamento Simples de Exames Médicos

Um projeto desenvolvido no Rebase Labs para o rastreamento e gerenciamento de exames médicos. Esta aplicação web permite a listagem e visualização de exames, com suporte para importação de dados e exibição de resultados de forma intuitiva.

### Funcionalidades

- **Importação de Dados:** Importa dados de exames a partir de arquivos CSV para um banco de dados SQL. Inclui uma ferramenta para importar os dados de forma assíncrona.
 ![Screenshot 2024-08-16 at 10 49 46](https://github.com/user-attachments/assets/db60ee2f-b572-496d-9d46-42245f5a7502)
- **Listagem de Exames:** Exibe uma lista de exames médicos em formato JSON e HTML.
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
