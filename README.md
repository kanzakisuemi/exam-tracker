# Acompanhamento Simples de Exames Médicos

Um projeto desenvolvido no Rebase Labs para o rastreamento e gerenciamento de exames médicos. Esta aplicação web permite a listagem e visualização de exames, com suporte para importação de dados e exibição de resultados de forma intuitiva.

### Funcionalidades

- **Importação de Dados:** Importa dados de exames a partir de arquivos CSV para um banco de dados SQL. Inclui uma ferramenta para importar os dados de forma assíncrona.
- **Listagem de Exames:** Exibe uma lista de exames médicos em formato JSON e HTML.
- **Detalhamento de Exames:** Permite a visualização dos detalhes de um exame específico com base em um token único.
- **API e Web Interface:** Oferece endpoints para a importação de dados e visualização de exames.

### Tecnologias Utilizadas

- **Backend:** Ruby com Sinatra
- **Frontend:** HTML, CSS, JavaScript
- **Banco de Dados:** PostgreSQL
- **Containerização:** Docker
- **Processamento Assíncrono:** Sidekiq

### Setup e Execução

- **Configuração do Ambiente:** Utilize Docker para configurar e rodar a aplicação e o banco de dados.
- **Importação de Dados:** Execute o script `import_from_csv.rb` para popular o banco de dados com dados de exames.
- **Execução da Aplicação:** Inicie a aplicação web para interagir com a API e visualizar os dados dos exames.

### Endpoints da API

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

### Docker Compose

Seu arquivo `docker-compose.yml` deve estar configurado como segue para rodar a aplicação e o banco de dados:

```yaml
version: '3'

services:
  db:
    image: postgres:14
    container_name: db
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: exam_db
    volumes:
      - db-data:/var/lib/postgresql/data

  api:
    image: ruby:3.1
    ports:
      - "7777:7777"
    volumes:
      - ".:/app"
    working_dir: /app
    command: bash -c 'bundle install --without test && ruby db/initialize_db.rb && bundle exec puma -C puma_api.rb'
    depends_on:
      - db
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: exam_db
      REDIS_URL: redis://redis:6379

  web:
    image: ruby:3.1
    ports:
      - "8888:8888"
    volumes:
      - ".:/app"
    working_dir: /app
    command: bash -c 'bundle install --without test && bundle exec puma -C puma_web.rb'
    depends_on:
      - api
  
  redis:
    image: redis:latest
    container_name: redis
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  sidekiq:
    image: ruby:3.1
    command: bash -c 'bundle install && bundle exec sidekiq -r ./sidekiq/*.rb'
    volumes:
      - ".:/app"
    working_dir: /app
    depends_on:
      - redis
      - api
    environment:
      REDIS_URL: redis://redis:6379

  test-api:
    container_name: test-api
    image: ruby:3.1
    depends_on:
      - api
    volumes:
      - .:/app
    working_dir: /app/api
    command: bash -c 'bundle install && bundle exec rspec'
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: test_db
      REDIS_URL: redis://redis:6379

  test-web:
    container_name: test-web
    image: ruby:3.1
    depends_on:
      - web
      - api
    volumes:
      - .:/app
    working_dir: /app/web
    command: bash -c 'bundle install && bundle exec rspec'
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: test_db
      REDIS_URL: redis://redis:6379

volumes:
  db-data:
  redis_data:
```

### About

Um projeto desenvolvido no Rebase Labs para o rastreamento e gerenciamento de exames médicos.
