# Acompanhamento Simples de Exames Médicos
Um projeto desenvolvido no Rebase Labs para o rastreamento e gerenciamento de exames médicos. Esta aplicação web permite a listagem e visualização de exames, com suporte para importação de dados e exibição de resultados de forma intuitiva.

### Funcionalidades
- Importação de Dados: Importa dados de exames a partir de arquivos CSV para um banco de dados SQL. Inclui uma ferramenta para importar os dados de forma assíncrona.
- Listagem de Exames: Exibe uma lista de exames médicos em formato JSON e HTML.
- Detalhamento de Exames: Permite a visualização dos detalhes de um exame específico com base em um token único.
- API e Web Interface: Oferece endpoints para a importação de dados e visualização de exames.
### Tecnologias Utilizadas
- Backend: Ruby com Sinatra
- Frontend: HTML, CSS, JavaScript
- Banco de Dados: PostgreSQL
- Containerização: Docker
- Processamento Assíncrono: Sidekiq
### Setup e Execução
- Configuração do Ambiente: Utilize Docker para configurar e rodar a aplicação e o banco de dados.
- Importação de Dados: Execute o script import_from_csv.rb para popular o banco de dados com dados de exames.
- Execução da Aplicação: Inicie a aplicação web para interagir com a API e visualizar os dados dos exames.
