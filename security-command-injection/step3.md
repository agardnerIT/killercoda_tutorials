# Preventing Injection Attacks

The first step is to never trust user-provided data. In the example, the issue was that we blindly trusted the text input. DO NOT DO THAT.

Always clean, sanitise and validate the data. For example, our app could first inspect the user input and if `;` is seen, that may be an indicator that a user is trying to do something strange.

The [OWASP page](https://owasp.org/Top10/A03_2021-Injection/) has more information on prevention technique.