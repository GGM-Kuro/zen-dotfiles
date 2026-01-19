---
name: agents-md
description: >
  AGENTS.md format and best practices for guiding coding agents.
  Trigger: When creating AGENTS.md files for AI agent guidance.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Basic Structure (REQUIRED)

```markdown
# AGENTS.md

This repository contains [describe project type and location]. When working on the project with an agent, please follow the guidelines below.

## 1. Development Environment
- [Key development command and when to use it]
- [Avoid commands that break hot reload]
- [Package manager specific tips]

## 2. Coding Conventions
- [Preferred file types and patterns]
- [Style guidelines]
- [File organization principles]

## 3. Testing & Quality
- [How to run tests]
- [Linting and type checking commands]
- [Quality gates before commits]

## 4. Useful Commands
| Command | Purpose |
|---------|---------|
| `dev_command` | [What it does] |
| `test_command` | [What it does] |
| `lint_command` | [What it does] |

---

Following these practices ensures agent-assisted development stays fast and dependable.
```

## Next.js Pattern (REQUIRED)

```markdown
# AGENTS.md

This repository contains a Next.js application located in the root. When working with the project with an agent, please follow the guidelines below so that HMR continues to work smoothly.

## 1. Use Development Server, not `npm run build`
- **Always use `npm run dev` (or `pnpm dev`, `yarn dev`)** while iterating. This starts Next.js in development mode with hot-reload enabled.
- **Do not run `npm run build` inside the agent session.** This switches to production assets which disables hot reload and can leave the dev server in inconsistent state.

## 2. Keep Dependencies in Sync
If you add or update dependencies remember to:
1. Update the appropriate lockfile (`package-lock.json`, `pnpm-lock.yaml`, `yarn.lock`)
2. Re-start the development server so Next.js picks up changes

## 3. Coding Conventions
- Prefer TypeScript (`.tsx`/`.ts`) for new components and utilities
- Co-locate component-specific styles in the same folder as the component when practical

## 4. Useful Commands
| Command | Purpose |
|---------|---------|
| `npm run dev` | Start Next.js dev server with HMR |
| `npm run lint` | Run ESLint checks |
| `npm run test` | Execute test suite |
| `npm run build` | **Production build – do not run during agent sessions** |

---

Following these practices ensures agent-assisted development workflow stays fast and dependable.
```

## React + Vite Pattern (REQUIRED)

```markdown
# AGENTS.md

This repository contains a React + Vite application. When working with the project with an agent, please follow the guidelines below.

## 1. Development Environment
- Use `pnpm dlx turbo run where <project_name>` to jump to a package instead of scanning with `ls`
- Run `pnpm install --filter <project_name>` to add the package to your workspace so Vite, ESLint, and TypeScript can see it
- Use `pnpm create vite@latest <project_name> -- --template react-ts` to spin up a new React + Vite package with TypeScript checks ready
- Check the name field inside each package's package.json to confirm the right name—skip the top-level one

## 2. Testing Instructions
- Find the CI plan in the `.github/workflows` folder
- Run `pnpm turbo run test --filter <project_name>` to run every check defined for that package
- From the package root you can just call `pnpm test`. The commit should pass all tests before you merge
- To focus on one step, add the Vitest pattern: `pnpm vitest run -t "<test name>"`
- Fix any test or type errors until the whole suite is green
- After moving files or changing imports, run `pnpm lint --filter <project_name>` to be sure ESLint and TypeScript rules still pass
- Add or update tests for the code you change, even if nobody asked

## 3. PR Instructions
- Title format: `[<project_name>] <Title>`
- Always run `pnpm lint` and `pnpm test` before committing

## 4. Useful Commands
| Command | Purpose |
|---------|---------|
| `pnpm dev` | Start development server |
| `pnpm test` | Run test suite |
| `pnpm lint` | Run linting and type checks |
| `pnpm build` | Production build |
```

## Python/FastAPI Pattern (REQUIRED)

```markdown
# AGENTS.md

This repository contains a FastAPI application. When working with the project with an agent, please follow the guidelines below.

## 1. Development Environment
- Use `uvicorn app.main:app --reload` for development with auto-reload
- **Do not use production server commands** (`gunicorn`, `uvicorn` without `--reload`) during development
- Use `python -m venv venv` for virtual environment setup
- Activate with `source venv/bin/activate` (Linux/Mac) or `venv\Scripts\activate` (Windows)

## 2. Dependencies Management
- Use `pip install -r requirements.txt` for dependencies
- Use `pip freeze > requirements.txt` to update lockfile
- Restart server after dependency changes

## 3. Coding Conventions
- Follow PEP 8 style guidelines
- Use type hints for all function parameters and return values
- Organize imports: standard library, third-party, local imports
- Keep API routes in `app/api/v1/` directory

## 4. Testing & Quality
- Run `pytest` for unit tests
- Run `pytest --cov=app` for coverage
- Run `black app/` for code formatting
- Run `flake8 app/` for linting
- Run `mypy app/` for type checking

## 5. Useful Commands
| Command | Purpose |
|---------|---------|
| `uvicorn app.main:app --reload` | Start dev server with hot reload |
| `pytest` | Run test suite |
| `black app/` | Format code |
| `flake8 app/` | Lint code |
| `mypy app/` | Type checking |
```

## Monorepo Pattern (REQUIRED)

```markdown
# AGENTS.md

This repository contains a monorepo with multiple packages. When working with the project with an agent, please follow the guidelines below.

## 1. Workspace Navigation
- Use `pnpm dlx turbo run where <project_name>` to jump to a package
- Run `pnpm install --filter <project_name>` to add package to workspace
- Check `package.json` name field to confirm correct package name
- Use `pnpm -C packages/<project_name>` to run commands in specific package

## 2. Development Commands
- Use `pnpm dev` to start all development servers
- Use `pnpm dev --filter <project_name>` for single package
- Use `turbo run dev --filter=<project_name>` for turbo monorepos

## 3. Testing & Quality
- Run `pnpm test` to test all packages
- Run `pnpm test --filter <project_name>` for specific package
- Use `pnpm lint` and `pnpm type-check` across workspace
- Fix any test or type errors before commits

## 4. PR Guidelines
- Title format: `[<project_name>] <Description>`
- Run `pnpm lint` and `pnpm test` before committing
- Include test updates for code changes

## 5. Useful Commands
| Command | Purpose |
|---------|---------|
| `pnpm install` | Install all workspace dependencies |
| `pnpm dev` | Start all dev servers |
| `pnpm test --filter <pkg>` | Test specific package |
| `pnpm lint --filter <pkg>` | Lint specific package |
| `turbo run build` | Build all packages |
```

## Commands (REQUIRED)

```bash
# Create AGENTS.md for Next.js project
cat > AGENTS.md << 'EOF'
# AGENTS.md

This repository contains a Next.js application located in the root. When working with the project with an agent, please follow the guidelines below so that HMR continues to work smoothly.

## 1. Use Development Server, not `npm run build`
- **Always use `npm run dev` (or `pnpm dev`, `yarn dev`)** while iterating. This starts Next.js in development mode with hot-reload enabled.
- **Do not run `npm run build` inside the agent session.** This switches to production assets which disables hot reload and can leave the dev server in inconsistent state.

## 2. Keep Dependencies in Sync
If you add or update dependencies remember to:
1. Update the appropriate lockfile (`package-lock.json`, `pnpm-lock.yaml`, `yarn.lock`)
2. Re-start the development server so Next.js picks up changes

## 3. Coding Conventions
- Prefer TypeScript (`.tsx`/`.ts`) for new components and utilities
- Co-locate component-specific styles in the same folder as the component when practical

## 4. Useful Commands
| Command | Purpose |
|---------|---------|
| `npm run dev` | Start Next.js dev server with HMR |
| `npm run lint` | Run ESLint checks |
| `npm run test` | Execute test suite |
| `npm run build` | **Production build – do not run during agent sessions** |

---

Following these practices ensures agent-assisted development workflow stays fast and dependable.
EOF

# Create AGENTS.md for React + Vite monorepo
cat > AGENTS.md << 'EOF'
# AGENTS.md

This repository contains a React + Vite monorepo. When working with the project with an agent, please follow the guidelines below.

## 1. Development Environment
- Use `pnpm dlx turbo run where <project_name>` to jump to a package instead of scanning with `ls`
- Run `pnpm install --filter <project_name>` to add the package to your workspace so Vite, ESLint, and TypeScript can see it
- Use `pnpm create vite@latest <project_name> -- --template react-ts` to spin up a new React + Vite package with TypeScript checks ready
- Check the name field inside each package's package.json to confirm the right name—skip the top-level one

## 2. Testing Instructions
- Find the CI plan in the `.github/workflows` folder
- Run `pnpm turbo run test --filter <project_name>` to run every check defined for that package
- From the package root you can just call `pnpm test`. The commit should pass all tests before you merge
- To focus on one step, add the Vitest pattern: `pnpm vitest run -t "<test name>"`
- Fix any test or type errors until the whole suite is green
- After moving files or changing imports, run `pnpm lint --filter <project_name>` to be sure ESLint and TypeScript rules still pass
- Add or update tests for the code you change, even if nobody asked

## 3. PR Instructions
- Title format: `[<project_name>] <Title>`
- Always run `pnpm lint` and `pnpm test` before committing

## 4. Useful Commands
| Command | Purpose |
|---------|---------|
| `pnpm dev` | Start development server |
| `pnpm test` | Run test suite |
| `pnpm lint` | Run linting and type checks |
| `pnpm build` | Production build |
EOF
```

## Keywords
agents.md, AI agents, coding guidelines, development workflow, documentation, best practices, AI collaboration