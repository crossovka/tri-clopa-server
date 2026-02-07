FROM node:20-alpine

WORKDIR /srv/app

# Копируем package.json отдельно для кэширования
COPY package.json yarn.lock ./

# Устанавливаем зависимости
RUN yarn install --frozen-lockfile

# Копируем ВСЕ файлы
COPY . .

# Собираем Strapi
RUN yarn build

# Меняем владельца файлов на не-root пользователя
RUN chown -R node:node /srv/app

# Переключаемся на обычного пользователя (БЕЗОПАСНОСТЬ!)
USER node

EXPOSE 1337

CMD ["yarn", "start"]