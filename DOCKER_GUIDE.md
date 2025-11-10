# Docker Guide - Running Containers Separately

## 1. Running Containers Separately

Yes! Your `docker-compose.yml` already defines **two separate containers**:
- `mern-memories-server` (backend)
- `mern-memories-client` (frontend)

### Option A: Run Only One Container

**Run only the server:**
```bash
docker-compose up server
# or in background
docker-compose up -d server
```

**Run only the client:**
```bash
docker-compose up client
# or in background
docker-compose up -d client
```

### Option B: Build and Run Containers Individually (Without docker-compose)

**Build server image:**
```bash
cd server
docker build -t mern-memories-server .
docker run -p 5000:5000 \
  -e CONNECTION_URL=your_mongodb_url \
  mern-memories-server
```

**Build client image:**
```bash
cd client
docker build -t mern-memories-client \
  --build-arg REACT_APP_API_URL=http://localhost:5000 .
docker run -p 3000:80 mern-memories-client
```

## 2. Docker Compose Override Files

Docker Compose automatically merges `docker-compose.override.yml` with `docker-compose.yml` if it exists. This is perfect for:
- Local development customizations
- Different configurations per environment
- Overriding settings without modifying the main file

### How Override Files Work

1. **Automatic Override**: If `docker-compose.override.yml` exists, Docker Compose automatically uses it
   ```bash
   docker-compose up  # Automatically uses override file
   ```

2. **Multiple Override Files**: You can specify multiple files
   ```bash
   docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
   ```

3. **Ignore Override**: Use only the base file
   ```bash
   docker-compose -f docker-compose.yml up
   ```

### Example: Create Override File

1. **Copy the example:**
   ```bash
   cp docker-compose.override.yml.example docker-compose.override.yml
   ```

2. **Customize it** for your local development needs

3. **Run normally:**
   ```bash
   docker-compose up --build
   ```
   The override file will automatically be merged!

### Common Override Use Cases

**Development Override** (`docker-compose.override.yml`):
- Volume mounts for hot-reload
- Different environment variables
- Development-specific settings

**Production Override** (`docker-compose.prod.yml`):
- Production environment variables
- Different restart policies
- Resource limits
- Health checks

## 3. Useful Commands

### Run specific services:
```bash
docker-compose up server client    # Run both
docker-compose up server           # Run only server
docker-compose up client           # Run only client
```

### Stop specific services:
```bash
docker-compose stop server
docker-compose stop client
docker-compose stop               # Stop all
```

### View logs:
```bash
docker-compose logs server
docker-compose logs client
docker-compose logs -f            # Follow all logs
```

### Rebuild specific service:
```bash
docker-compose build server
docker-compose build client
docker-compose up --build server  # Build and start
```

### Remove containers:
```bash
docker-compose down               # Stop and remove
docker-compose down -v           # Also remove volumes
```

## 4. Current Setup

Your current `docker-compose.yml`:
- ✅ **Server container**: Runs on port 5000
- ✅ **Client container**: Runs on port 3000 (maps to nginx port 80)
- ✅ **Separate containers**: They're already separate!
- ✅ **Network**: Both on `mern-network` so they can communicate

The containers are **separate** but can communicate through the Docker network using service names (`server` and `client`).

