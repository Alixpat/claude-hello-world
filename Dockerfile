ARG REGISTRY

FROM ${REGISTRY}/python:3.12-slim

ARG PIP_INDEX_URL

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir \
    ${PIP_INDEX_URL:+--index-url "$PIP_INDEX_URL"} \
    ${PIP_INDEX_URL:+--trusted-host "$(echo $PIP_INDEX_URL | sed 's|https\?://\([^/:]*\).*|\1|')"} \
    -r requirements.txt

COPY . .

RUN python manage.py collectstatic --noinput 2>/dev/null || true

EXPOSE 1000
CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:1000"]
