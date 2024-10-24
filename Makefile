.PHONY: django
django:
	mod_wsgi-express start-server core/wsgi.py --port=8080 --reload-on-changes --log-to-terminal