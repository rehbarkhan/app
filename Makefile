.PHONY: django
django:
	mod_wsgi-express start-server core/wsgi.py --port=8080 --reload-on-changes --log-to-terminal

.PHONY: base-image
base-imager:
	docker build -f devtools/dockerfiles/Dockerfile.base -t saas:v1 .

# setting the eng
# set "MOD_WSGI_APACHE_ROOTDIR=C:\Apache24"