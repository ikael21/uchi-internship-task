
# Uchi Internship Task

Перед запуском нужно установить

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/)

- Запустить приложение

```bash
docker compose up
```

или

```bash
make app
```

## OpenAPI документация

- [localhost:3000/api-docs](http://localhost:3000/api-docs/)

## Допущения

- `Class` переименован в `SchoolClass`, так как `Class` является зарезервированным словом в Ruby и использование его в модели приводит к неоднозначностям и потенциальным конфликтам в коде (например, с `Object#class`).

## Полезные команды

- Зайти в консоль

```bash
make app-console
```

