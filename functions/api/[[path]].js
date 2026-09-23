import app from '../../worker/index.js';
export async function onRequest(context){return app.fetch(context.request,context.env)}
