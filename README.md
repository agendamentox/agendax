# AgendaX Cloudflare Final v5

SaaS de agendamento multiusuário preparado para Cloudflare Pages + Pages Functions + D1.

## O que já funciona
- Login real com usuário/senha e sessão persistente no D1
- Sem cadastro público direto: o acesso nasce somente após confirmação do pagamento
- Checkout por Pix manual com chave configurável pelo Admin
- Pedidos pendentes / pagos / cancelados
- Confirmação de pagamento gera automaticamente usuário `@AgendaX`, senha aleatória, negócio e dados iniciais
- Cliente consegue voltar ao link do pedido e consultar se o acesso já foi liberado
- Admin-chefe: criar, bloquear, ativar, redefinir senha e excluir usuários
- Admin-chefe: alterar plano e configurar Pix/CNPJ, recebedor, WhatsApp e preços
- Multiempresa: dados separados por negócio
- Agenda pública, clientes, serviços, equipe/comissão, produtos, financeiro, despesas, relatórios, backup e CSV
- PWA
- Google Agenda por OAuth (opcional; basta configurar as 3 variáveis do Google)

## Infraestrutura
- Frontend: HTML/CSS/JavaScript em `public/`
- Backend: Cloudflare Pages Functions em `functions/api/[[path]].js`
- Banco: Cloudflare D1
- Não precisa de VPS, Express ou SQLite local.

## Variáveis obrigatórias no Cloudflare
Crie em Settings > Variables and Secrets:
- `APP_SECRET`: uma string longa e aleatória (mínimo recomendado: 32 caracteres)
- `ADMIN_EMAIL`: seu e-mail de administrador
- `ADMIN_PASSWORD`: sua senha inicial do Admin (mínimo 8 caracteres)

O primeiro acesso à API cria o Admin automaticamente se ainda não existir.

## Google Agenda (opcional)
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `GOOGLE_REDIRECT_URI` = `https://SEU-DOMINIO.pages.dev/api/google/callback`

## Banco D1
1. Crie um D1 chamado `agendax-db`.
2. Execute o conteúdo de `schema.sql` no console SQL do D1.
3. No projeto Pages, crie o binding D1 com nome de variável exatamente `DB` apontando para `agendax-db`.
4. Faça um novo deploy depois de criar o binding.

## Publicação pelo GitHub
- Framework preset: None
- Build command: vazio
- Build output directory: `public`
- Root directory: `/`
- A pasta `functions/` precisa permanecer na raiz do repositório.

## Primeiro uso
1. Abra o site e entre com `ADMIN_EMAIL` + `ADMIN_PASSWORD`.
2. Vá em **Admin SaaS**.
3. Informe sua chave Pix/CNPJ e nome do recebedor.
4. Ajuste os preços dos planos.
5. O site já passa a mostrar essa chave no checkout.

## Fluxo do cliente
1. Cliente clica em Assinar.
2. Preenche dados e escolhe o plano.
3. O AgendaX mostra seu Pix/CNPJ e cria um pedido pendente.
4. Você confere o Pix no banco.
5. No Admin, clica em **Confirmar pagamento**.
6. O sistema cria usuário, senha, negócio e libera o painel automaticamente.
7. As credenciais aparecem para você e também no link privado do pedido do cliente.
8. O cliente entra e pode trocar a senha.
