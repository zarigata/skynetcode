# Security Policy

```
 ████████╗ █████╗ ███████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗
 ╚══██╔══╝██╔══██╗██╔════╝██╔═══██╗██║    ██║██║████╗  ██║
    ██║   ███████║███████╗██║   ██║██║ █╗ ██║██║██╔██╗ ██║
    ██║   ██╔══██║╚════██║██║   ██║██║███╗██║██║██║╚██╗██║
    ██║   ██║  ██║███████║╚██████╔╝╚███╔███╔╝██║██║ ╚████║
    ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝
                   SECURITY POLICY
```

## 🔒 Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 2.x     | ✅ Active support  |
| 1.x     | ⚠️ Security fixes only |
| < 1.0   | ❌ No longer supported |

## 🛡️ Security Features

T-800 includes several security-conscious design decisions:

### Telemetry
- **PII Redaction**: Automatic redaction of passwords, API keys, tokens
- **Local Only**: No network transmission of telemetry data
- **Opt-In**: Users must explicitly enable telemetry
- **Sensitive Path Protection**: Redacts paths like ~/.ssh, ~/.config

### Recovery
- **No Auto-Fix**: Never automatically fixes security-sensitive errors
- **Escalation**: Security operations trigger human-in-the-loop
- **Audit Logging**: All recovery actions logged

### Authentication Operations
- **Permission Checks**: Verifies permissions before auth-related changes
- **Human Approval Required**: All security-impacting operations escalate to user

## 🚨 Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability, please report it responsibly.

### How to Report

1. **DO NOT** open a public issue
2. Email security details to the maintainer
3. Or use GitHub's Security Advisory feature

### What to Include

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### Response Timeline

| Stage | Timeframe |
|-------|-----------|
| Initial Response | Within 48 hours |
| Vulnerability Assessment | Within 7 days |
| Fix Development | Varies by severity |
| Release | After testing |

### Severity Levels

```
┌─────────────────────────────────────────────────────────────┐
│ CRITICAL: Remote code execution, data exposure            │
│ HIGH: Authentication bypass, privilege escalation         │
│ MEDIUM: Information disclosure, denial of service          │
│ LOW: Minor information leaks, UI issues                    │
└─────────────────────────────────────────────────────────────┘
```

## 🔐 Security Best Practices

When using T-800:

1. **Review Agent Output**: Always review code changes before applying
2. **Secure Credentials**: Never commit API keys or tokens
3. **Enable PII Redaction**: Keep telemetry privacy-focused
4. **Audit Changes**: Review all file modifications
5. **Human-in-the-Loop**: Use HITL patterns for security-sensitive operations

## 📋 Security Checklist

Before deploying T-800:

- [ ] Telemetry PII redaction enabled
- [ ] Cost limits configured
- [ ] HITL triggers include security operations
- [ ] No secrets in agent configurations
- [ ] Recovery escalation thresholds set appropriately