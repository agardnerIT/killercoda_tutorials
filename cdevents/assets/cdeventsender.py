import asyncio
import nats
import argparse
import json
import uuid
import datetime

parser = argparse.ArgumentParser()

# Notes:
# You can use either short or long (mix and match is OK)
# Hyphens are replaced with underscores hence for retrieval
# and leading hyphens are trimmed
# --span-name becomes args.span_name
# Retrieval also uses the second parameter
# Hence args.dry_run will work but args.d won't
parser.add_argument('-ep', '--endpoint', required=False)
parser.add_argument('-sub', '--subject', required=True)
parser.add_argument('-t', '--event-type', required=True)

args = parser.parse_args()

endpoint = args.endpoint
subject = args.subject
event_type = args.event_type
message = {} # The CDEvent, built below

# Default to localhost:4222
if endpoint is None:
    endpoint = "localhost:4222"

# Build message from file
with open(f"spec/examples/{event_type}.json", "r") as file:
    message = json.load(file)
    # Set new id and timestamp field to be unique and "now"
    iso_timestamp = datetime.datetime.now().isoformat()
    id = uuid.uuid4()

    message['context']['id'] = str(id)
    message['context']['timestamp'] = iso_timestamp


print(f"Sending message type: {event_type} to subject: {subject} on endpoint: {endpoint}")

async def main():

    # Connect to NATS endpoint
    nc = await nats.connect(f"nats://{endpoint}")
    # Publish message
    await nc.publish(subject, json.dumps(message).encode('utf-8'))

if __name__ == '__main__':
    asyncio.run(main())