# ===== STAGE 1: Build admin =====
FROM node:20-alpine AS builder

WORKDIR /srv/app

# Кэшируем зависимости
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Копируем все исходники
COPY . .

# Собираем Strapi (admin + backend)
RUN yarn build

# ===== STAGE 2: Production =====
FROM node:20-alpine

WORKDIR /srv/app

# Копируем только prod зависимости
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production

# Копируем сборку и исходники
COPY --from=builder /srv/app .

# Экспонируем порт для internal Traefik
EXPOSE 1337

# Запуск Strapi в production
CMD ["yarn", "start"]
