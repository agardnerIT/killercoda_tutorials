# What is Command Injection

Simply put, it is the ability to run extra or "incorrect" commands via a vulnerable script or application, commands that the author or system administrator probably never intended you to run.

## Scenario
Imagine a script (or website) that asks users for an IP address or URL. The script (or website) will then use that input to `ping` the endpoint or address.

Sounds harmless right?

### Try It

Click the following to run the script. When prompted, enter `example.com`.

```
python3 app.py
```{{exec}}

The script pings `example.com` and exits.

## Dangerous?

Instead of typing `example.com`. Type this instead: `example.com ; ls -l`

Again the script will ping `example.com` but it will then show you a directory listing on the server.

That is not what the author of this application intended. Since you can now see all files in this directory, this is also a security risk.

## Explanation

The semicolon `;` character is a command separator character meaning "do this" then "do this other thing". So first the script pings `example.com` then it runs `ls -l` which lists the current directory.

## What Else Can I Do?

Anything you want. You have unlimited access to the command line:

- See which user you are: `example.com ; whoami`
- Show every user on the system: `example.com ; getent passwd`
- Create a File: `example.com ; echo "some file content" > my_new_file.txt ; ls -l ; cat my_new_file.txt`
- Delete files: `example.com ; rm my_new_file.txt ; ls -l`