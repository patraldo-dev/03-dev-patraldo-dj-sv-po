ARG PYTHON_VERSION=3.11-slim

FROM python:${PYTHON_VERSION}

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /code

WORKDIR /code

RUN pip install poetry
COPY pyproject.toml poetry.lock /code/
RUN poetry config virtualenvs.create false
RUN poetry install --only main --no-root --no-interaction
COPY . /code

ENV SECRET_KEY "5PFcMtufFdV1zzau8yyfbtpdBm2pcn5WWNHmFQUfBDsRQP5D6K"
#ENV SECRET_KEY "non-secret-key-for-building-purposes"  # <-- Updated!
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["gunicorn","--bind",":8000","--workers","2","myapp.wsgi"]
