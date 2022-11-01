# What is SQL Injection

## What is SQL?
To understand a SQL injection attack, let's first understand SQL.

SQL is Structured Query Language. It is a way to interact with SQL databases. As the name suggests, there is a certain structure.

Imagine a SQL table called `Accounts` containing user accounts. This table has the following fields:

- FirstName
- LastName
- Address
- Balance

The demo database has accounts for:
- "Joe Bloggs"
- "Sarah Peters"
- "Phil Power"

Using SQL I can retrieve the address of a specific user with a query like this:

`SELECT Address FROM Accounts WHERE LastName="Bloggs"`

The query will search the database and return the `Address` field for any row that matches the `LastName` of `Bloggs`

## Try it

Click the following text to run the application.

```
python3 app.py
```{{exec}}

When prompted, enter `bloggs` (all lowercase). The application match on last name is case sensitive so you should not see any details.

Now try: `Bloggs`. The application should return the user details for `Joe Bloggs`.

## Injecting SQL?

For demo purposes, the application prints the SQL statement used.

Now try typing this:

```
fake' OR true;--
```{{copy}}

Wow! Now you've got access to ALL user details. I'm not sure you're supposed to have that level of access!

You have just executed a SQL injection attack.

## What Happened?

When you entered `Bloggs`, the SQL statement was:

```
SELECT rowid, firstname, lastname, address, balance
FROM Accounts
WHERE LastName='Bloggs'
```{{copy}}

This matched and a valid user was returned.

When you entered `fake' OR true;--` the SQL statement was:

```
SELECT rowid, firstname, lastname, address, balance
FROM Accounts
WHERE LastName='fake' OR true;--'
```{{copy}}

At first glance it doesn't look like it should work. `fake` isn't a valid `LastName` after all.

## Explanation

`fake'` was used just to keep the SQL engine happy. The extra apostrophe closed the `LastName` brackets.
`OR true` always evaluates to `true`. This is really the dangerous part.

You can now read this SQL statement as "give me the details from Accounts where `LastName` equals `fake` OR just give me everything". Of course you get everything: SQL is working as designed, you have just manipulated it.

The `;` is how you tell SQL to end the line. But remember, there is also a pesky extra apostraphe from the original SQL statement.

Luckily, SQL has a handy operator (a double dash) which means "ignore everything after this". Therefore the `;` is the last thing actually "used" by SQL. Everything is ignored.