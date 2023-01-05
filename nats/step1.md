## Subject Based Messaging

Fundamentally, NATS is about publishing and listening for messages. Both of these depend heavily on Subjects.

## What is a Subject?
At its simplest, a subject is just a string of characters that form a name which the publisher and subscriber can use to find each other. It helps scope messages into streams or topics.

![subject based messaging](./assets/images/subject-based-messaging-1.png)

A lot more information is available in the [official documentation](https://docs.nats.io/nats-concepts/subjects).

## Enough Reading - Test It Out!

Enough reading, it is time to test out NATS.

First, connect to the `nats-box` (this is a handy wrapper useful for quick demos). `nats-box` comes preconfigured with the CLI tools you need.

```
kubectl exec -n nats -it deployment/my-nats-box -- /bin/sh -l
```{{exec}}

Now simulate a subscriber and subscribe to the `test` subject:

```
nats sub test
```{{exec}}

You should see output similar to this:

```
my-nats-box-6b696cf559-x4c8r:~# 06:43:36 Subscribing on test
```{{}}

Open a new terminal window by clicking the <kbd>+</kbd> button. Connect again to the `nats-box` and publish a message to the `test` subject:

```
kubectl exec -n nats -it deployment/my-nats-box -- /bin/sh -l
nats pub test "hello world"
```{{exec}}

You should see:

```
06:44:48 Published 11 bytes to "test"
```{{}}

Flick back to Tab 1 and you should see output similar to this:

```
[#1] Received on "test"
hello world
```{{}}

## Bonus: Experiment with Subjects

NATS recommends building subjects using dot separators eg: `io.nats.cities` or `io.nats.countries` and keeping the number of tokens to less than 16.

A subject "exists" as soon as it has a subscriber (there is no implicit "create subject" command).

Open a new terminal, connect to `nats-box` and subscribe to a new subject, for example: `names.dog`:

```
kubectl exec -n nats -it deployment/my-nats-box -- /bin/sh -l
nats sub names.dog
```{{exec}}

Open another new terminal and subscribe to a different subject called: `names.cat`:

```
kubectl exec -n nats -it deployment/my-nats-box -- /bin/sh -l
nats sub names.cat
```{{exec}}

> Check your subscriptions at anytime by opening a terminal and running `top`

```
top
```{{exec}}

It should show something like this (3 subscribers are active to 3 subjects):

```
  PID  PPID USER     STAT   VSZ %VSZ CPU %CPU COMMAND
  230     6 root     S     716m  36%   0   0% nats sub names.cat
  223     6 root     S     716m  36%   0   0% nats sub names.dog
  217     6 root     S     716m  36%   0   0% nats sub test
    6     0 root     S     1696   0%   0   0% /bin/sh -l
  236     6 root     R     1612   0%   0   0% top
    1     0 root     S     1604   0%   0   0% tail -f /dev/null
  215     6 root     T     1600   0%   0   0% top
```{{}}

Open yet another terminal and publish a dog name. As expected, it is only received by the listeners on `names.dog`:

```
kubectl exec -n nats -it deployment/my-nats-box -- /bin/sh -l
nats pub names.dog Lassie
```{{exec}}

You should see:

```
# nats pub names.dog Lassie
07:12:04 Published 6 bytes to "names.dog"
```{{}}