# AgendaX — GitHub + Cloudflare Pages + D1

Arquitetura do site da Suzana: frontend Vite, API em Pages Functions e banco D1. **Este projeto é Cloudflare Pages, não Workers.** O ZIP tem uma pasta única: envie **o conteúdo dessa pasta** para a raiz do repositório, de modo que `package.json`, `index.html`, `functions/` e `schema.sql` fiquem na raiz.

## Publicar do zero

1. Crie um repositório `agendax` no GitHub e envie todos os arquivos e pastas do projeto. Não envie o ZIP fechado nem crie uma pasta extra dentro do repositório.
2. Na Cloudflare, crie o banco D1 `agendax-db`. Na aba **Console** do banco, execute todo o conteúdo de `schema.sql` uma única vez. Confira se a tabela `system_settings` apareceu.
3. Em **Workers & Pages → Create → Pages → Connect to Git**, selecione o repositório `agendax` e a branch `main`.
4. Configure: **Framework preset: Vite**, **Build command: `npm run build`**, **Build output directory: `dist`**, **Root directory: `/`**. O campo de **Deploy command** deve ficar vazio: o Pages publica automaticamente após o build.
5. No projeto **Pages**, abra **Settings → Bindings → Add binding → D1 database**. Nome da variável: `DB`. Selecione `agendax-db`. Adicione o binding tanto em **Production** quanto em **Preview**, caso use os dois ambientes. Após salvar, refaça o deployment.
6. Em **Settings → Variables and Secrets**, adicione como **secrets** `ADMIN_EMAIL`, `ADMIN_PASSWORD` (mínimo 8 caracteres) e `APP_SECRET` (frase aleatória longa). Configure em Production. Refaça o deployment se necessário.
7. Abra `https://SEU-PROJETO.pages.dev/api/health` e confirme que retorna JSON; depois entre no site com o e-mail e a senha do passo 6.

**Não é necessário** cadastrar um Database ID nos arquivos. As senhas não ficam no GitHub. Um novo commit na `main` dispara o novo build.

## Uso

O admin configura Pix, nome do recebedor e preços. O cliente faz o pedido, recebe link com token e aguarda a confirmação manual; o admin confirma e gera login `@AgendaX` e senha temporária. O painel do assinante reúne agenda, clientes, serviços, profissionais/comissões, estoque, despesas, relatórios, backup JSON e CSV. Cada conta usa o próprio negócio no D1. A página pública fica em `/agendar/slug-do-negocio` e tem rota própria no Pages. O Google Agenda exige `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` e `GOOGLE_REDIRECT_URI=https://SEU-PROJETO.pages.dev/api/google/callback` e consentimento OAuth no Google Cloud. Sem isso o restante da plataforma funciona.

### Rodar no computador (opcional)

`npm install` e `npm run dev` mostram a interface em `http://localhost:5173`. Para testar a API e o D1 localmente, é necessária uma configuração temporária do Wrangler e executar `schema.sql`; o frontend isolado não grava dados.

### Observações

O Pix e a liberação são manuais. Não há cobrança recorrente, envio automático pelo WhatsApp ou sincronização bidirecional com Google Calendar. O backup JSON exporta dados; a importação substitui registros do negócio e deve ser usada com cuidado. `schema.sql` é voltado para banco novo; para manter dados de uma implantação antiga, é necessária migração específica.
