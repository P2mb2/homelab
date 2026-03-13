# Deploy

## 0. Setup env

```bash
cp .env.example .env
# Edit .env and fill in your tokens
```

## 1. Login to GHCR

Create a [Personal Access Token](https://github.com/settings/tokens) with `write:packages` scope, add it to `.env`, then:

```bash
source .env
echo $CR_PAT | docker login ghcr.io -u p2mb2 --password-stdin
```

## 2. Build & Push

```bash
docker build -t ghcr.io/p2mb2/openclaw-custom:latest .
docker push ghcr.io/p2mb2/openclaw-custom:latest
```

Or using the script:

```bash
bash build_and_push.sh
```

## 3. Update Portainer

Pull the new image in Portainer and redeploy the stack.

```bash
docker pull ghcr.io/p2mb2/openclaw-custom:latest
```
