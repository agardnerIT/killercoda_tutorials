import os

# -c 2 just means "do two ping requests"
# 3. Enter "-c 1 google.com & ls -l" (on linux)

exit = False

while not exit:
    user_input = input("Enter the URL / IP to ping: ")
    if user_input == "exit": exit = True

    os.system(f"ping -c 2 {user_input}")