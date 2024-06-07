# Перший етап: збірка образу
FROM node:14-alpine AS build

# Встановлюємо робочу директорію всередині контейнера
WORKDIR /app

# Копіюємо package.json і package-lock.json для встановлення залежностей
COPY package*.json ./

# Встановлюємо залежності
RUN npm install --production

# Копіюємо інші файли проекту
COPY . .

# Другий етап: створення мінімального фінального образу
FROM node:14-alpine

# Встановлюємо робочу директорію всередині контейнера
WORKDIR /app

# Копіюємо тільки необхідні файли з першого етапу
COPY --from=build /app /app

# Вказуємо команду для запуску додатку
CMD ["node", "index.js"]
