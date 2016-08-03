FROM python:2
ENV PYTHONUNBUFFERED 1
MAINTAINER Ian THomas <ianedwardthomas@gmail.com>
WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt
COPY terrain.py /usr/src/app/terrain.py
COPY features /usr/src/app/features
ENTRYPOINT ["lettuce"]
