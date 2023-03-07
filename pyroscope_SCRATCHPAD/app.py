import pyroscope
import time

pyroscope.configure(
  application_name = "my.python.app", # replace this with some name for your application
  server_address   = "http://my-pyroscope-server:4040", # replace this with the address of your pyroscope server
)

def functionA():
    print("In function A. Sleeping...")
    time.sleep(2)
    print("In functionA. Done sleeping...")

if __name__ == __main__:
    functionA()
