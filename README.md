# AgendaX Cloudflare Worker v6

Versão preparada para Cloudflare Workers Builds + Static Assets + D1.

## Deploy
- Build command: vazio
- Deploy command: `npx wrangler deploy`
- Preview command: `npx wrangler versions upload` (opcional)

## D1
Após o primeiro deploy, crie um banco D1 chamado `agendax-db` e adicione ao Worker um binding chamado exatamente `DB`.
O próprio Worker cria as tabelas automaticamente no primeiro acesso à API.

## Variáveis/segredos
Configure no Worker:
- `ADMIN_EMAIL`
- `ADMIN_PASSWORD` (mínimo 8 caracteres)
- `APP_SECRET` (texto longo aleatório)

Google Agenda opcional:
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `GOOGLE_REDIRECT_URI`
