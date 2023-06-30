import sqlite3
import os

# 1. Enter "peters" (without double quotes). Result = no account found (case sensitive)
# 2. Enter "Peters" (without double quotes). Result = Account found
# 3. SQL Injection to retrieve data: Enter "fake' OR true --" (without double quotes). Result = SQL injection. All accounts shown.

connection = sqlite3.connect("sql_injection_database.db")
cursor = connection.cursor()

def init_db():
    with open('schema.sql', mode='r') as f:
        cursor.executescript(f.read())
    connection.commit()

init_db()

exit = False
while not exit:
    print("Type the word 'exit' (without quotes) at any time to exit...")
    print()
    user_input = input("Enter your surname: ")
    if user_input == "exit": exit = True

    select_statement = f"SELECT rowid, firstname, lastname, address, accounttype, balance FROM Accounts WHERE LastName='{user_input}'"
    print(f"Here is the SELECT statement that will be executed")
    print("-"*60)
    print(select_statement)
    print("-"*60)
    print() # Empty line
    try:
        rows = cursor.execute(select_statement).fetchall()

        if len(rows) < 1:
            print("No Account found with that surname...");
        else:
            print("PRINTING OUTPUT")
            print("="*60)
            
            for row in rows:
                print(row)
            
            print("="*60)
    except Exception as e:
        print("Exception caught retrieving data from DB")
        print(e)

connection.close()