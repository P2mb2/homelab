# OpenClaw — Post-Install Reference

## Device Pairing (code 1008 — "pairing required")

Occurs when a new browser, device, or CLI instance connects to the gateway and requires authorization.

**1. List pending device requests:**
```bash
openclaw devices list 
```

**2. Approve the latest pending request:**
```bash
openclaw devices approve --latest
```

**Or approve a specific request by ID:**
```bash
openclaw devices approve  <requestId>
```
