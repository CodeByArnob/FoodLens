# Security Policy

## Supported Versions

The following versions of FoodLens currently receive security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | Yes                |
| < 1.0.0 | No                 |

---

## Reporting a Vulnerability

The FoodLens team takes the security of our application, user privacy, and decentralized client-side architecture seriously.

If you discover a security vulnerability or credential exposure risk, please report it responsibly:

1. Do NOT file a public GitHub issue for sensitive security vulnerabilities.
2. Contact the maintainer directly through GitHub private reporting or via:
   Maintainer: CodeByArnob (https://github.com/CodeByArnob)
3. Include the following details in your report:
   - Description of the vulnerability and affected component.
   - Exact steps or proof-of-concept to reproduce the issue.
   - Potential impact on user data or Puter credit allowances.
   - Any suggested mitigations or patches.

---

## Security Guidelines for FoodLens Development

- No Hardcoded Secrets: Never commit keystores, signing keys, private credentials, or API tokens to the public repository.
- User-Pays Protection: Protect user credit quotas. Never expose a user's Puter token in logs or URL parameters.
- WebView Security: Keep JavaScript interfaces restricted to necessary methods only, and validate all inputs received across the JavaScript channel.
- Local Storage: Store sensitive user preferences locally using platform-recommended secure storage mechanisms.
