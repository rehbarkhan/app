# app
### SaaS Product: **Complete School Management System (SMS)**


# Loggin Logic
Setting up logging in Django allows you to track events and errors in your application. Django uses Python's built-in `logging` module, and you can configure it to log messages to various destinations (e.g., files, console, email).

Here's a step-by-step guide to setting up logging in a Django project:

### 1. Configure Logging in `settings.py`

Django's logging configuration is defined in the `settings.py` file. By default, Django comes with a basic logging configuration, but you can customize it to suit your needs.

Here’s an example logging setup for your `settings.py`:

```python
# settings.py

import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,  # Keep Django's default loggers
    'formatters': {  # Define the output format of logs
        'verbose': {
            'format': '{levelname} {asctime} {module} {message}',
            'style': '{',
        },
        'simple': {
            'format': '{levelname} {message}',
            'style': '{',
        },
    },
    'handlers': {  # Define where logs are written (e.g., file, console)
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'simple',
        },
        'file': {
            'level': 'ERROR',
            'class': 'logging.FileHandler',
            'filename': os.path.join(BASE_DIR, 'django_error.log'),
            'formatter': 'verbose',
        },
    },
    'loggers': {  # Configure loggers for different parts of the project
        'django': {
            'handlers': ['console', 'file'],
            'level': 'DEBUG',
            'propagate': True,
        },
        'django.request': {
            'handlers': ['file'],
            'level': 'ERROR',
            'propagate': False,
        },
        'myapp': {  # Replace 'myapp' with your app's name
            'handlers': ['console'],
            'level': 'DEBUG',
            'propagate': True,
        },
    },
}
```

### 2. Explanation of the Configuration

- **`version`**: This is always `1` (required by Python's logging module).
- **`disable_existing_loggers`**: If `False`, Django’s default loggers remain active.
- **`formatters`**: Formatters define how logs are displayed. The `verbose` formatter shows more details (log level, timestamp, module, and message), while `simple` is less verbose.
- **`handlers`**: Handlers determine where log messages go:
  - `console`: Logs messages to the console (useful for development).
  - `file`: Logs messages to a file (`django_error.log` in this case).
- **`loggers`**: Loggers allow you to configure logging behavior for different parts of your project. You can set log levels and handlers for Django, your own apps, or external packages.
  - `'django'`: This is Django’s main logger.
  - `'django.request'`: Logs unhandled requests and exceptions (such as 404 or 500 errors).
  - `'myapp'`: Replace `'myapp'` with your application’s name to configure logging specifically for it.

### 3. Using Logging in Your Django Code

Once logging is configured, you can use it in your views, models, or any other part of your code.

```python
import logging

# Get an instance of a logger
logger = logging.getLogger(__name__)

def my_view(request):
    logger.debug('This is a debug message')
    logger.info('This is an info message')
    logger.warning('This is a warning message')
    logger.error('This is an error message')
    logger.critical('This is a critical message')
```

### 4. Log Levels

The log level determines the severity of the messages logged:

- `DEBUG`: Detailed information for diagnosing problems.
- `INFO`: General information about the system’s operation.
- `WARNING`: Indicates that something unexpected happened, but the program is still functioning.
- `ERROR`: A more serious problem that prevents part of the program from functioning.
- `CRITICAL`: A serious error that may stop the program entirely.

### 5. Rotate Logs (Optional)

To prevent your log files from growing indefinitely, you can use `logging.handlers.RotatingFileHandler` for log rotation.

Example:

```python
'file': {
    'level': 'ERROR',
    'class': 'logging.handlers.RotatingFileHandler',
    'filename': os.path.join(BASE_DIR, 'django_error.log'),
    'maxBytes': 1024*1024*5,  # 5 MB
    'backupCount': 5,  # Keep up to 5 backup log files
    'formatter': 'verbose',
},
```

This configuration keeps the log size under 5 MB and retains up to 5 old log files.

### 6. Check Logs

- **In the console**: If you’re running the Django development server (`python manage.py runserver`), logs will appear in the terminal.
- **In the log file**: Errors or other messages will be logged to the file (`django_error.log`) if specified.

This setup will help you track issues during development and in production, making it easier to troubleshoot problems in your Django application.
