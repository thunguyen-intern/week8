# Prometheus and Grafana

## Prometheus

### Installation

* Create a network `prom`:

```bash
$ docker network create prom --driver bridge
```

* Write `docker-compose.yml` file:

```
prometheus:
    image: prom/prometheus:v2.45.0
    volumes:
      # bind mount: prometheus dir
      - ./prometheus/:/etc/prometheus/
    ports:
      - 9090:9090
    networks:
      - prom
    restart: always
```

### Alertmanager

## Grafana

Run Grafana:

```bash
$ docker run --name=grafana -p 3000:3000 -e GF_SECURITY_ADMIN_PASSWORD=admin -e GF_USERS_ALLOW_SIGN_UP=false grafana/grafana
```
