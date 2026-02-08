FROM node:20-alpine

WORKDIR /srv/app

# Копируем package.json отдельно для кэширования
COPY package.json yarn.lock ./

# Устанавливаем зависимости
RUN yarn install --frozen-lockfile --production

# Копируем ВСЕ файлы
COPY . .

# Собираем Strapi
RUN yarn build

EXPOSE 1337

# Старт команда (Dokploy добавит свои переменные)
CMD ["yarn", "start"]