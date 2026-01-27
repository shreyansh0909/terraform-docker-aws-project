# Stage 1 — build
FROM node:18-alpine AS builder
WORKDIR /app

# Install dependencies (including devDeps needed for next build)
COPY package*.json ./
RUN npm ci

# Copy source
COPY . .

# Build Next.js for production (creates .next)
ENV NODE_ENV=production
RUN npm run build

# Stage 2 — production image
FROM node:18-alpine AS runner
WORKDIR /app

# Only copy needed files from builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/next.config.js ./next.config.js

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["node", "server.js"]
