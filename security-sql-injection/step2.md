# How Dangerous is This Really?

Despite the first SQL injection being reporting in 1998 (nearly 25 years ago), it is **still** in the [OWASP Top 3 vulnerabilities](https://owasp.org/Top10/A03_2021-Injection/). So very dangerous and still very much an issue.

This demo shows things running from the command line, but imagine instead that the text input came from a website on the internet - now anyone in the world can retrieve all your user data.

## Only SQL Affected?

OWASP uses hte more generic term of "Injection" because actually, lots of technologies are vulnerable to similar attacks:

- SQL
- NoSQL
- Object Relational Mapping (ORM) tools