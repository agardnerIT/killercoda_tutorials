# Prevention of Path Traversal

The easiest way is to avoid user input. If you do allow user input, validate against known good (or accepted) values. Never sanitise or try to "guess" the correct value from what a user entered - there will almost always be a way for an attacked to "out-guess" yours algorithm.

Use CMS systems, frameworks and existing standards where possible. This is not a novel attack vector - others have already solved this problem and it is probably quicker (and more secure) for you to leverage their work than re-inventing the wheel.

Do not store sensitive information inside the website root directory

Do not run your website as the `root`{{}} user where possible.

The OWASP has a page dedicated to [Path Traversal](https://owasp.org/www-community/attacks/Path_Traversal) where you can learn more.