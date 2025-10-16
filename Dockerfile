# Dockerfile
FROM node:20-alpine

# Crea una mini app senza dipendenze esterne
WORKDIR /app
RUN cat > server.js <<'EOF'
const http = require('http');

const PORT = process.env.PORT || 80;

const server = http.createServer((req, res) => {
  // Normalizza eventuale trailing slash
  const url = req.url.replace(/\/+$/, '') || '/';

  if (req.method === 'GET' && url === '/clara/test/path') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    return res.end('ok: clara/test/path');
  }

  // Health check semplice
  if (req.method === 'GET' && url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    return res.end('healthy');
  }

  res.writeHead(404, { 'Content-Type': 'text/plain' });
  res.end('not found');
});

server.listen(PORT, () => {
  console.log(`listening on ${PORT}`);
});
EOF

EXPOSE 80
CMD ["node", "server.js"]

