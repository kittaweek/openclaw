# OpenClaw 🦞

Multi-channel AI gateway and agent runner. This repository is managed via **Docker** and a simplified **Makefile**.

## Prerequisites

- **Docker** & **Docker Compose**
- **make** utility

---

## 1. Environment Configuration

You must configure your `.env` file before running the setup.

### Step 1: Create .env
```bash
cp .env.example .env
```

### Step 2: Configure variables
Open `.env` and set your preferred values. Common variables include:

| Variable | Description | Default |
| :--- | :--- | :--- |
| `OPENCLAW_IMAGE` | Docker image to use | `openclaw:local` |
| `OPENCLAW_CONFIG_DIR` | Directory for persistent config | `.openclaw` |
| `OPENCLAW_WORKSPACE_DIR` | Directory for agent workspace | `.openclaw/workspace` |
| `OPENCLAW_GATEWAY_PORT` | Port for the gateway API | `18789` |
| `OPENCLAW_TZ` | Timezone for the container | `UTC` |
| `OPENCLAW_SANDBOX` | Enable browser/code sandbox (0/1) | `0` |

### Step 3: Export Environment (Recommended)
Before running `make setup`, export your variables to ensure the setup script picks up any overrides.

**For Bash / Zsh:**
```bash
export $(grep -v '^#' .env | xargs)
```

**For Fish:**
```fish
for line in (grep -v '^#' .env | grep '=')
  set -gx (string split -m 1 '=' $line)
end
```

---

## 2. Setup Guide

Running OpenClaw through the **Makefile** ensures consistency across environments.

### 🏠 Local Setup
1.  Run the setup wizard:
    ```bash
    make setup
    ```
2.  **Required Selections**:
    - **Setup mode**: Choose `Manual`.
    - **Gateway Bind**: Choose `LAN (0.0.0.0)` (to allow access from your host browser).
    - Follow prompts to add your API keys.

### 🌐 Production Setup
1.  Configure your server's `.env` (ensure `OPENCLAW_GATEWAY_TOKEN` is strong).
2.  Run `make setup`.
3.  Once onboarding is done, standard startup is handled by:
    ```bash
    make up
    ```

---

## 3. Usage & Management

All lifecycle commands are handled via `make`:

-   `make up` / `make down`: Start or stop services.
-   `make status`: Check container health.
-   `make logs`: Watch real-time logs.
-   `make login`: Link messaging accounts (WhatsApp QR, etc.).
-   `make shell-gateway`: Enter the gateway container shell.
-   `make cli cmd="..."`: Run OpenClaw CLI (e.g., `make cli cmd="config list"`).
-   `make build` / `make pull`: Manage images.

---

## 4. Pairing Devices

To let agents interact with your messaging accounts:
1.  Ensure you have run `make login` to authorize the channel.
2.  Send a message to your bot from the target device.
3.  If pairing is required, use the CLI inside the container:
    ```bash
    docker exec -it openclaw-gateway openclaw devices list
    docker exec -it openclaw-gateway openclaw devices approve <REQUEST_ID>
    ```
---
## Open mode Sandbox
docker compose run --rm openclaw-cli config set agents.defaults.sandbox.mode non-main

## Further Reading
Visit [docs.openclaw.ai](https://docs.openclaw.ai) for deep-dive configuration and security hardening.
