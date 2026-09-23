AGENDAX PREMIUM — BUILD 3

ARQUIVOS PRINCIPAIS
- index.html: site + painel + pagina publica
- manifest.webmanifest: instalacao PWA
- sw.js: cache/offline basico
- icon.svg: icone do app
- _headers: cabecalhos recomendados para Cloudflare Pages
- agendax-preview.html: copia da pagina principal para compatibilidade

LOGIN DA DEMONSTRACAO
demo@agendax.app
Senha: 123456

O QUE FOI ADICIONADO
- Google Agenda com onboarding simples
- Gestao de equipe/profissionais e comissao
- Relatorios de faturamento, confirmacao, faltas e ranking
- Busca e exportacao CSV de clientes
- Exportacao de relatorio CSV
- Backup e importacao JSON
- Regras de lembrete, cancelamento, janela de agenda e intervalo
- Compartilhamento do link publico
- PWA instalavel com manifest + service worker
- Melhorias gerais no painel e area de configuracoes

IMPORTANTE
Esta versao e um front-end estatico funcional de demonstracao. Os dados ficam no localStorage do navegador. Para vender como SaaS real multiusuario, ainda sera necessario backend/autenticacao real, banco de dados, cobranca recorrente, OAuth real do Google Calendar, envio real de WhatsApp/e-mail e regras de seguranca/permissoes.

CLOUDFLARE PAGES
Por ser HTML estatico, nao precisa de npm. Use o repositorio como raiz. Build command: exit 0 (ou deixe vazio se o painel permitir). Build output directory: .
