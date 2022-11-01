# How do I prevent Injection Attacks

The first step is to never trust user-provided data. In the example, the issue was that we blindly trusted the text input. DO NOT DO THAT.

Always clean, sanitise and validate the data. For example, our app could first inspect the user input and if `--` is seen, that may be an indicator that a user is trying to do something strange.

Use SQL controls such as the `LIMIT` keyword to limit the number of records returned to a user, even if an injection occurs. At least it will slow an attacker down.

Many frameworks also check (or attempt to check) for SQL injection.

Some open source and commercial products offer automated SQL injection blocking at runtime.

The [OWASP page](https://owasp.org/Top10/A03_2021-Injection/) has more information on prevention technique.