# How Dangerous is This Really?

Year after year, injection attacks are consistently in the [OWASP Top 10 vulnerabilities](https://owasp.org/Top10/A03_2021-Injection/). So very dangerous and still very much an issue.

This demo shows things running from the command line, but imagine instead that the text input came from a website on the internet - now anyone in the world can retrieve all your user data.

## Only the Command Line Affected?

OWASP uses the more generic term of "Injection" because actually, lots of technologies are vulnerable to similar attacks:

- Command line (as shown here)
- SQL
- NoSQL
- Object Relational Mapping (ORM) tools
- etc.