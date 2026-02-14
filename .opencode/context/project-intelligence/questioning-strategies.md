# T-800 Questioning Strategies

## Strategy 1: Funnel Technique
Start broad, narrow down systematically.

**Pattern**:
1. High-level: "What are you building?"
2. Medium-level: "What features does it need?"
3. Detail-level: "How should feature X work?"

## Strategy 2: Five Ws
Classic journalistic questioning.

**Questions**:
- **WHO**: Who will use this?
- **WHAT**: What does it do?
- **WHEN**: When will it be used?
- **WHERE**: Where will it be deployed?
- **WHY**: Why is this needed?

## Strategy 3: Edge Case Exploration
Hunt for edge cases systematically.

**Pattern**:
- "What if the user enters...?"
- "What if the network fails...?"
- "What if the data is corrupted...?"
- "What if there are concurrent requests...?"
- "What if the system is under load...?"

## Strategy 4: Scenario Walkthrough
Walk through user scenarios step by step.

**Pattern**:
1. "A user opens the app, what do they see?"
2. "They click login, what happens?"
3. "Login succeeds, where do they go?"
4. "They want to do X, how do they do it?"
5. "Something goes wrong, what do they see?"

## Strategy 5: Constraint Discovery
Find hidden constraints and limits.

**Questions**:
- "Maximum number of users?"
- "Maximum data size?"
- "Maximum response time acceptable?"
- "Minimum uptime required?"
- "Budget constraints?"
- "Timeline constraints?"

## Strategy 6: Integration Discovery
Find external dependencies.

**Questions**:
- "Does this need to connect to anything else?"
- "Are there existing systems to integrate with?"
- "Any third-party services needed?"
- "Any shared databases?"
- "Any authentication systems to connect to?"

## Strategy 7: Security Interrogation
Explore security requirements.

**Questions**:
- "Who should NOT have access?"
- "What data is sensitive?"
- "How is sensitive data protected?"
- "What authentication method?"
- "What authorization levels exist?"
- "How are passwords stored?"
- "Is encryption needed?"

## Strategy 8: Performance Probing
Explore performance requirements.

**Questions**:
- "How many concurrent users expected?"
- "What response time is acceptable?"
- "What's the expected data volume?"
- "Any reporting or analytics needs?"
- "Any caching requirements?"

## Strategy 9: Compliance Checking
Explore regulatory and compliance needs.

**Questions**:
- "Any regulatory requirements? (GDPR, HIPAA, etc.)"
- "Any data retention policies?"
- "Any audit trail requirements?"
- "Any accessibility requirements? (WCAG)"
- "Any industry standards to follow?"

## Strategy 10: Future-Proofing
Explore future scalability and evolution.

**Questions**:
- "How might this grow in the future?"
- "What features might be added later?"
- "How scalable does this need to be?"
- "Any plans for mobile/tablet?"
- "Any internationalization needs?"

## Question Bank by Project Type

### Web Application Questions
- "Single-page app or traditional?"
- "What browsers must be supported?"
- "Mobile-responsive needed?"
- "Offline functionality needed?"

### API Questions
- "REST or GraphQL?"
- "What authentication method?"
- "Rate limiting needed?"
- "API versioning strategy?"

### Mobile App Questions
- "iOS, Android, or both?"
- "Native or cross-platform?"
- "Offline-first?"
- "Push notifications?"

## Question Pacing

### Start Slow
- Build rapport
- Establish trust
- Show understanding

### Go Deep
- Ask follow-up questions
- Explore implications
- Challenge assumptions

### Summarize
- Repeat back understanding
- Confirm alignment
- Document decisions
