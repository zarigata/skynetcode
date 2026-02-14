# T-800 Planning Templates

## Template 1: Web Application

# Project: [Application Name]

## Overview
[2-3 sentence description]

## Technology Stack
- Frontend: React/Next.js
- Backend: Node.js/Express
- Database: PostgreSQL
- Cache: Redis
- Deployment: [Target]

## Architecture

### Frontend
```
src/
├── components/      # Reusable UI components
├── pages/           # Page components
├── hooks/           # Custom React hooks
├── services/        # API service layer
├── utils/           # Utility functions
├── types/           # TypeScript types
└── styles/          # Global styles
```

### Backend
```
src/
├── routes/          # API routes
├── controllers/     # Request handlers
├── services/        # Business logic
├── models/          # Data models
├── middleware/      # Express middleware
├── utils/           # Utilities
└── types/           # TypeScript types
```

## Features

### Authentication
- [ ] User registration
- [ ] Email verification
- [ ] Login/logout
- [ ] Password reset
- [ ] Session management

### Core Features
- [ ] Feature 1: [Description]
- [ ] Feature 2: [Description]
- [ ] Feature 3: [Description]

## Testing

### Frontend
- Component tests: Jest + React Testing Library
- E2E tests: Playwright
- Coverage: 80%

### Backend
- Unit tests: Jest
- Integration tests: Supertest
- Coverage: 90%

## Deployment

### Prerequisites
- Node.js 20+
- PostgreSQL 16
- Redis 7+

### Environment Variables
```
DATABASE_URL=
REDIS_URL=
JWT_SECRET=
SMTP_HOST=
SMTP_USER=
SMTP_PASS=
```

---

## Template 2: REST API

# Project: [API Name]

## Overview
[Description of API purpose]

## Endpoints

### Resource: [Resource Name]

#### List
```
GET /api/[resource]
Query params: page, limit, sort, filter
Response: { data: [], total: number, page: number }
```

#### Get
```
GET /api/[resource]/:id
Response: { data: {} }
```

#### Create
```
POST /api/[resource]
Body: { [fields] }
Response: { data: {} }
```

#### Update
```
PATCH /api/[resource]/:id
Body: { [fields] }
Response: { data: {} }
```

#### Delete
```
DELETE /api/[resource]/:id
Response: { success: boolean }
```

## Authentication
- Type: JWT
- Header: Authorization: Bearer <token>
- Refresh: POST /api/auth/refresh

## Rate Limiting
- Limit: 100 requests per minute
- Headers: X-RateLimit-Limit, X-RateLimit-Remaining

## Error Responses
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": {}
  }
}
```

---

## Template 3: CLI Tool

# Project: [CLI Name]

## Overview
[Description of CLI purpose]

## Commands

### `cli init`
Initialize a new project
```
Options:
  --template <name>  Use template
  --force            Overwrite existing
```

### `cli build`
Build the project
```
Options:
  --output <dir>     Output directory
  --minify           Minify output
  --watch            Watch for changes
```

### `cli test`
Run tests
```
Options:
  --coverage         Generate coverage
  --watch            Watch mode
```

## Exit Codes
- 0: Success
- 1: General error
- 2: Invalid arguments
- 3: File not found
- 4: Permission denied

---

## Template 4: Library/Package

# Project: [Library Name]

## Overview
[Description of library purpose]

## Installation
```bash
npm install [package-name]
# or
yarn add [package-name]
```

## API

### `[Function/Class Name]`
```typescript
import { [Name] } from '[package-name]';

const instance = new [Name](options);
await instance.method();
```

### Options
| Option | Type | Default | Description |
|--------|------|---------|-------------|
| option1 | string | '' | Description |
| option2 | number | 0 | Description |

### Methods
- `method1(arg1: string): Promise<Result>` - Description
- `method2(): void` - Description

### Events
- `event1` - Triggered when...
- `event2` - Triggered when...

## Peer Dependencies
- dependency1: ^1.0.0
- dependency2: ^2.0.0
