FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npx tsc && \
    cp index.html dist/ && \
    cp -r styles dist/ && \
    cp -r images dist/

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html