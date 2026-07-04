# jack-stack

## Oracle Database + ORDS (SQL Developer Web) - Docker Compose Project

This project runs an Oracle Database (Free edition) together with Oracle REST Data Services (ORDS),
which provides Oracle SQL Developer Web in your browser. It also includes init scripts that set up
schema and seed data automatically on first startup.

## Project Structure

```
.
├── docker-compose.yml
└── init-scripts/
    ├── 001_setup_schema.sql
    └── 002_seed_data.sql
```

## Prerequisites

- Docker Desktop or Docker Engine installed
- Docker Compose v2 (comes bundled with modern Docker installs, invoked as `docker compose`, no hyphen)
- At least 4 GB of free RAM for the Oracle container

## Quick Start

```bash
# Start everything in the background
docker compose up -d

# Watch the database boot up (wait for "DATABASE IS READY TO USE!")
docker compose logs -f oracle-db
```

Once ready:
- Database: connect on `localhost:1521`, service name `FREEPDB1`
- SQL Developer Web: open http://localhost:8080/ords/sql-developer in your browser

## Common Docker Compose Commands (Beginner Guide)

Docker Compose lets you define and run multi-container applications from a single YAML file.
Below are the commands you'll use most often, explained simply.

| Command | What it does |
|---|---|
| `docker compose up` | Builds (if needed) and starts all services, showing logs in your terminal |
| `docker compose up -d` | Same as above, but runs in the background ("detached mode") so you get your terminal back |
| `docker compose down` | Stops and removes all containers, networks created by `up` (keeps volumes/data) |
| `docker compose down -v` | Same as `down`, but also deletes volumes -- use this to wipe the database and start fresh |
| `docker compose ps` | Lists the containers in this project and their status (running, stopped, healthy) |
| `docker compose logs` | Shows logs from all services |
| `docker compose logs -f oracle-db` | Follows (streams) logs live from just the `oracle-db` service; Ctrl+C to stop watching |
| `docker compose stop` | Stops running containers without removing them (keeps them so you can restart quickly) |
| `docker compose start` | Starts containers that were stopped with `stop` |
| `docker compose restart` | Stops and starts services again (useful after changing environment variables) |
| `docker compose exec oracle-db bash` | Opens an interactive shell inside the running `oracle-db` container |
| `docker compose config` | Validates and prints the fully resolved compose file (good for catching YAML errors) |
| `docker compose pull` | Downloads the latest versions of the images defined in the compose file |
| `docker compose build` | Rebuilds images for services that have a `build:` section (not needed here since we use prebuilt images) |
| `docker compose top` | Shows the running processes inside each container |

### Typical Beginner Workflow

1. `docker compose up -d` -- start everything
2. `docker compose ps` -- check that containers are running and healthy
3. `docker compose logs -f oracle-db` -- watch startup progress
4. Do your work (connect, query, develop)
5. `docker compose down` -- stop everything when done (data is preserved in the volume)
6. `docker compose down -v` -- only when you want a completely clean slate (deletes all data)

## Init Scripts

Files in `init-scripts/` are executed once, in alphabetical order, the very first time the database
container initializes. They will NOT run again on subsequent restarts unless you delete the data
volume first (`docker compose down -v`).

## Git and GitHub: Basic Commands for Beginners

Git tracks changes to your files locally. GitHub hosts a copy of your project online so you (and others)
can access it from anywhere. Below is the essential workflow.

### One-Time Setup

```bash
# Tell Git who you are (only needed once per machine)
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### Starting a New Project

```bash
# Turn the current folder into a Git repository
git init

# Check which files are tracked, changed, or new
git status

# Stage files (prepare them to be saved in a commit)
git add .              # stages everything
git add docker-compose.yml   # stages just one file

# Save a snapshot of staged changes with a message
git commit -m "Initial commit: oracle docker compose setup"
```

### Connecting to GitHub

1. Create a new, empty repository on github.com (do not initialize it with a README if you already have local files).
2. Copy the repository URL (HTTPS or SSH).
3. Link your local repo to it and push:

```bash
# Add GitHub as the "origin" remote (only once)
git remote add origin https://github.com/your-username/your-repo.git

# Rename your branch to "main" if it is currently "master" (GitHub default is "main")
git branch -M main

# Push your commits to GitHub and set "origin main" as the default upstream
git push -u origin main
```

After this first push, future pushes only need:

```bash
git push
```

### Everyday Commands

| Command | What it does |
|---|---|
| `git status` | Shows what's changed, staged, or untracked |
| `git add <file>` | Stages a specific file for the next commit |
| `git add .` | Stages all changed/new files in the current folder |
| `git commit -m "message"` | Saves staged changes as a new commit with a description |
| `git push` | Uploads your local commits to GitHub |
| `git pull` | Downloads and merges the latest changes from GitHub into your local branch |
| `git log` | Shows commit history |
| `git diff` | Shows exact line-by-line changes not yet staged |
| `git branch` | Lists branches; `git branch new-feature` creates one |
| `git checkout new-feature` | Switches to another branch |
| `git clone <url>` | Downloads an existing GitHub repo to your machine |
| `git remote -v` | Shows which remote URLs your repo is connected to |

### Authentication Note

GitHub no longer accepts your account password for `git push` over HTTPS. When prompted for a
password, use a Personal Access Token (create one under GitHub Settings > Developer settings >
Personal access tokens) instead. Alternatively, set up SSH keys to avoid typing credentials every time.

### Recommended .gitignore for This Project

Create a `.gitignore` file so you don't accidentally commit secrets or local Docker data:

```
.env
*.log
oracle-data/
```

## Environment Variables

Create a `.env` file next to `docker-compose.yml` (and add it to `.gitignore`) to avoid hardcoding
passwords:

```
ORACLE_PASSWORD=YourStrongPass123
APP_USER_PASSWORD=YourAppPass123
```

Compose automatically reads `.env` and substitutes `${ORACLE_PASSWORD}` style variables in the YAML file.
