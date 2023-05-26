FROM python:3.8-slim-buster
ENV PYTHONUNBUFFERED=1
WORKDIR /app

COPY requirements.txt requirements.txt
COPY rewatchables-on-netflix.sh /app/rewatchables-on-netflix.sh
COPY rewatchables-on-netflix.py /app/rewatchables-on-netflix.py
COPY rewatchables-tmdb-ids.csv /app/rewatchables-tmdb-ids.csv
RUN mkdir available
RUN pip install -r requirements.txt

CMD ./rewatchables-on-netflix.sh
