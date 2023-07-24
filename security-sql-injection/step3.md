# How do I prevent Injection Attacks

The safest way to avoid SQL injection attacks is simply to not use SQL! The problem is that the language inherently supports this injection behaviour. Everything else - all mitigation techniques - are bolt-ons, after the fact. It shifts the burden to developers to mitigate against something that the language inherently allows. Therefore, all it takes is one developer to forgot or one developer to mis-implement the protection mechanisms and the database is vulnerable.

If you do insist (or need to) use SQL:

The first step is to never trust user-provided data. In the example, the issue was that we blindly trusted the text input. DO NOT DO THAT.

Always clean, sanitise and validate the data. For example, our app could first inspect the user input and if `--` is seen, that may be an indicator that a user is trying to do something strange. DO NOT try to parse the data: Don't try to "guess" what the input *should* have said. You can guarantee that attackers are smarter (and have more time to poke holes). If the input looks wrong, throw it away and send an error message. Don't try to out-think or out-smart the attackers.

Use SQL controls such as the `LIMIT` keyword to limit the number of records returned to a user, even if an injection occurs. At least it will slow an attacker down.

Many frameworks also check (or attempt to check) for SQL injection.

Some open source and commercial products offer automated SQL injection blocking at runtime.

The [OWASP page](https://owasp.org/Top10/A03_2021-Injection/) has more information on prevention techniques.