# Summary

[Web parameter tampering](https://owasp.org/www-community/attacks/Web_Parameter_Tampering) (what you did here), enables parameter enumeration.

Parameter tampering is the first part: the ability to change something (like the `id`{{}} in a web address). You can then "cycle" (or enumerate) through the parameters (`ids`{{}}) to see everyone in the mailing list.

## How Dangerous is This?
Web parameter tampering and parameter enumeration are basically types of broken access control. You can easily access information you should not be able to access. This is the [OWASPs number 1, most common vulnerability](https://owasp.org/Top10/A01_2021-Broken_Access_Control/). So very common and obviously very critical to business protection.

Again, just imagine this demo was real. I'd have your entire mailing list now or I could have emptied your mailing list.

## How Can I Protect Against This?
In general, never give the user an option to "cycle" through things. If you do, at least make the IDs random (or none sequential) so they are harder to guess (imagine the user IDs weren't `1`{{}}, `2`{{}} and `3`{{}} but instead `aFG4X!@da`{{}}, `mMb5432!!--3`{{}} and `xP-+4886bVf~`{{}}). Those IDs are much harder to guess and almost impossible to automatically "cycle through".

Use combinations of things. For example, a unique "additional parameter" for each ID. Eg. `id=1`{{}} can only access their account when they also use this in the URL: `secret=!A-fgd_nkf--+sjh^sAAB`. Even if you use `?id=2&secret=!A-fgd_nkf--+sjh^sAAB`{{}} it wouldn't work - because user ID 2 has a different `secret`{{}} value assigned to them.