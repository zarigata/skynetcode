# T-800 Reasoning Patterns

Advanced reasoning patterns to enhance T-800's thinking capabilities.

## Pattern 1: Chain-of-Thought (CoT)

### Description
Step-by-step reasoning that breaks down complex problems into sequential thoughts.

### When to Use
- Complex multi-step problems
- Mathematical reasoning
- Logical inference
- Code debugging

### Template
```
Let me think through this step by step:

1. First, I need to understand [X]
2. Then, I need to consider [Y]
3. Next, I should analyze [Z]
4. Finally, I can conclude [result]

Therefore, the answer is...
```

### Example
```
User: "Which is larger: the product of all primes under 10 or 100?"

T-800 (Chain of Thought):
Let me think through this step by step:

1. First, I need to identify all primes under 10
   - Primes: 2, 3, 5, 7

2. Then, I need to calculate the product
   - 2 × 3 = 6
   - 6 × 5 = 30
   - 30 × 7 = 210

3. Now, compare with 100
   - 210 > 100

Therefore, the product of all primes under 10 (210) is larger than 100.
```

## Pattern 2: Tree of Thoughts (ToT)

### Description
Explore multiple solution paths in parallel, then select the best one.

### When to Use
- Problems with multiple valid solutions
- Creative tasks
- Decision making under uncertainty
- Planning complex projects

### Template
```
Let me explore multiple approaches:

Branch A: [Approach 1]
- Pros: [advantages]
- Cons: [disadvantages]
- Expected outcome: [result]

Branch B: [Approach 2]
- Pros: [advantages]
- Cons: [disadvantages]
- Expected outcome: [result]

Branch C: [Approach 3]
- Pros: [advantages]
- Cons: [disadvantages]
- Expected outcome: [result]

Best approach: [selected branch] because [reasoning]
```

### Example
```
User: "How should I implement user authentication?"

T-800 (Tree of Thoughts):
Let me explore multiple approaches:

Branch A: Session-based authentication
- Pros: Simple, stateful, easy to implement
- Cons: Server memory usage, scaling challenges
- Expected outcome: Quick implementation, good for small apps

Branch B: JWT token authentication
- Pros: Stateless, scalable, works well with microservices
- Cons: Token revocation complexity, larger payload
- Expected outcome: Modern approach, good for distributed systems

Branch C: OAuth 2.0 with third-party providers
- Pros: No password management, trusted, secure
- Cons: External dependency, user experience considerations
- Expected outcome: Best security, delegated identity

Best approach: For your use case (small team, single server), 
Branch A (Session-based) provides the simplest path with the 
fastest implementation. Consider migrating to JWT (Branch B) 
when you need to scale.
```

## Pattern 3: Self-Reflection (Reflexion)

### Description
Agent reviews its own output and iterates to improve quality.

### When to Use
- Code generation
- Critical reasoning
- Quality-sensitive outputs
- Learning from mistakes

### Template
```
Initial thought: [first attempt]

Self-Reflection:
- What could be wrong with this?
- What assumptions did I make?
- What edge cases did I miss?

Improved thought: [refined attempt]

Final answer: [best version]
```

### Example
```
User: "Write a function to check if a string is a palindrome"

T-800 (Self-Reflection):
Initial thought:
function isPalindrome(str) {
  return str === str.split('').reverse().join('');
}

Self-Reflection:
- What could be wrong with this?
  → Doesn't handle case sensitivity
  → Doesn't ignore non-alphanumeric characters
  → Doesn't handle empty strings well

- What assumptions did I make?
  → Assumed input is clean
  → Assumed case-sensitive comparison

Improved thought:
function isPalindrome(str) {
  const cleaned = str.toLowerCase().replace(/[^a-z0-9]/g, '');
  return cleaned === cleaned.split('').reverse().join('');
}

Self-Reflection 2:
- What edge cases did I miss?
  → null/undefined input
  → Single character strings

Final answer:
function isPalindrome(str) {
  if (!str) return false;
  const cleaned = str.toLowerCase().replace(/[^a-z0-9]/g, '');
  return cleaned.length > 0 && 
         cleaned === cleaned.split('').reverse().join('');
}
```

## Pattern 4: Debate & Verification

### Description
Consider multiple perspectives before making decisions.

### When to Use
- Architecture decisions
- Security-sensitive choices
- Performance-critical decisions
- Multi-stakeholder considerations

### Template
```
Perspective 1 - [Role A]: [viewpoint]
Perspective 2 - [Role B]: [viewpoint]
Perspective 3 - [Role C]: [viewpoint]

Common ground: [agreements]
Resolving conflicts: [how to reconcile]

Final decision: [synthesis]
```

### Example
```
User: "Should I use SQL or NoSQL for my application?"

T-800 (Debate):
Perspective 1 - DBA: SQL provides ACID guarantees, structured 
data, and proven reliability. Your data seems relational.

Perspective 2 - DevOps: NoSQL offers horizontal scaling, 
flexible schema, and faster development cycles. Consider 
future growth.

Perspective 3 - Security: SQL databases have mature security
features and audit capabilities. NoSQL security varies.

Common ground: Both can work, need to clarify requirements first.

Resolving conflicts: Your data is relational by nature (users,
orders, products). Start with PostgreSQL for ACID guarantees.
Add Redis for caching. Consider migration path to distributed
SQL (CockroachDB) if you need scale.

Final decision: Use PostgreSQL as primary database with Redis
for caching. This gives you reliability, security, and a 
clear scaling path.
```

## Pattern 5: Decomposition & Recomposition

### Description
Break complex problems into sub-problems, solve each, then combine.

### When to Use
- Complex algorithms
- System design
- Large feature implementation
- Refactoring

### Template
```
Decompose:
1. [Sub-problem 1]
2. [Sub-problem 2]
3. [Sub-problem 3]

Solve each:
1. [Sub-problem 1] → [solution]
2. [Sub-problem 2] → [solution]
3. [Sub-problem 3] → [solution]

Recompose:
Combine solutions: [integration]
Final result: [complete solution]
```
