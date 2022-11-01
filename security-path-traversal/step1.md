# What is a Path Traversal Vulnerability?

Usually when you have access to a system, you are only allowed in certain directories. It is similar to being allowed in an open home, but some of the doors are locked.

A directory traversal attack effectively lets you open up those locked doors.

## Demonstrate a Path / Directory Traversal Attack

[Click here to visit your website]({{TRAFFIC_HOST1_5000}}).

Click the link on that page to show the `file.txt`{{}}.

You should see the file contents printed to the screen. This is fine. You _should_ be able to see this file.

Now modify the URL and instead of `file.txt`{{}} at the end, make it read `/etc/passwd`{{copy}}. Hit enter.

You now can see every user currently registered on this system because someone started the webserver with `root` permissions.

This is a directory traversal attack. You can see content in a different directory that you were never supposed to be able to see.
