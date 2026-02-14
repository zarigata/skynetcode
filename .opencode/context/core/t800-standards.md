# T-800 Coding Standards

## Purpose
Load these standards before generating any T-800 code.

## Code Style

### Naming Conventions
- **Variables**: `camelCase`
- **Functions**: `camelCase`
- **Classes**: `PascalCase`
- **Constants**: `UPPER_SNAKE_CASE`
- **Files**: `kebab-case.ts`
- **Components**: `PascalCase.tsx`

### TypeScript Standards

Always use explicit types:
```typescript
interface User {
  id: string;
  email: string;
  name: string;
}

type UserRole = 'admin' | 'user' | 'guest';

const ROLES = ['admin', 'user', 'guest'] as const;
```

### Error Handling

Use Result pattern for operations:
```typescript
type Result<T, E = Error> = 
  | { success: true; data: T }
  | { success: false; error: E };

async function createUser(data: UserData): Promise<Result<User>> {
  try {
    const user = await db.users.create(data);
    return { success: true, data: user };
  } catch (error) {
    return { success: false, error: error as Error };
  }
}
```

### Testing Standards

```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create a user with valid data', async () => {
      const result = await createUser(validData);
      expect(result.success).toBe(true);
    });

    it('should return error with invalid email', async () => {
      const result = await createUser({ ...validData, email: 'invalid' });
      expect(result.success).toBe(false);
    });
  });
});
```

## Project Structure

```
project/
├── src/
│   ├── modules/           # Feature modules
│   ├── shared/            # Shared utilities
│   └── index.ts           # Entry point
├── tests/
│   ├── integration/
│   └── e2e/
├── docs/
└── package.json
```

## Quality Checklist

Before marking any code complete, verify:
- [ ] All types are explicit
- [ ] All errors are handled
- [ ] All functions tested
- [ ] All edge cases covered
- [ ] All code documented
- [ ] All conventions followed
