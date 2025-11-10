# Docker Setup for MERN Memories

This guide explains how to build and run the MERN Memories application using Docker.

## Prerequisites

- Docker installed on your system
- Docker Compose installed (usually comes with Docker Desktop)

## Quick Start

1. **Create environment file:**
   ```bash
   cp .env.example .env
   ```
   Edit `.env` and add your MongoDB connection URL and API URL.

2. **Build and run with Docker Compose:**
   ```bash
   docker-compose up --build
   ```

3. **Access the application:**
   - Client: http://localhost:3000
   - Server API: http://localhost:5000

## Building Individual Images

### Build Server Image
```bash
cd server
docker build -t mern-memories-server .
docker run -p 5000:5000 -e CONNECTION_URL=your_mongodb_url mern-memories-server
```

### Build Client Image
```bash
cd client
docker build -t mern-memories-client .
docker run -p 3000:80 -e REACT_APP_API_URL=http://localhost:5000 mern-memories-client
```

## Environment Variables

### Server
- `CONNECTION_URL`: MongoDB connection string
- `PORT`: Server port (default: 5000)

### Client
- `REACT_APP_API_URL`: Backend API URL that the browser will use to connect to the server (default: http://localhost:5000)
  - For local Docker: use `http://localhost:5000`
  - For production: use your actual domain/API URL

## Docker Compose Commands

- Start services: `docker-compose up`
- Start in background: `docker-compose up -d`
- Stop services: `docker-compose down`
- Rebuild images: `docker-compose up --build`
- View logs: `docker-compose logs -f`

## Production Considerations

1. **Environment Variables**: Never commit `.env` files with sensitive data
2. **MongoDB**: Use a managed MongoDB service (MongoDB Atlas) or run MongoDB in a separate container
3. **Security**: Update CORS settings in production
4. **HTTPS**: Use a reverse proxy (nginx) with SSL certificates for production
5. **Database**: The hardcoded MongoDB connection in `server/index.js` should be replaced with environment variables

## Troubleshooting

- If the client can't connect to the server, check the `REACT_APP_API_URL` environment variable
- Ensure MongoDB connection string is correct
- Check Docker logs: `docker-compose logs [service-name]`

