FROM public.ecr.aws/amazonlinux/amazonlinux:2

RUN yum -y update && \
    yum -y install python3 && \
    yum -y clean all && \
    rm -rf /var/cache/yum

RUN mkdir -p /srv && cat > /srv/server.py << 'PY'
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/clara/path/test":
            body = "Clara path test OK!\n"
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(body.encode())
        else:
            self.send_response(404)
            self.end_headers()

    def log_message(self, *args): pass

HTTPServer(("", 3000), Handler).serve_forever()
PY

EXPOSE 80
CMD ["python3", "/srv/server.py"]
