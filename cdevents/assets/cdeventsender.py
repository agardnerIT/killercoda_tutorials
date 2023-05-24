import asyncio
import nats
import argparse
import json
import pickle
import secrets

# CDEvent Types
TYPE_PIPELINERUN_QUEUED = "pipelinerun.queued"
TYPE_PIPELINERUN_STARTED = "pipelinerun.started"
TYPE_PIPELINERUN_FINISHED = "pipelinerun.finished"

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
parser.add_argument('-t', '--type', required=True)

args = parser.parse_args()

endpoint = args.endpoint
subject = args.subject
type = args.type
message = {} # The CDEvent, built below

# Default to localhost:4222
if endpoint is None:
    endpoint = "localhost:4222"

if type == TYPE_PIPELINERUN_QUEUED:

    id = secrets.token_hex(16)

    message = {
        "id": id,
        "type": "pipelinerun.queued"
    }


print(f"Sending message type: {type} to subject: {subject} on endpoint: {endpoint}")
print(f"Message body: {message}")
print(type(message))
print(pickle.dumps(message))

async def main():

    # Connect to NATS endpoint
    nc = await nats.connect(f"nats://{endpoint}")
    # Publish message
    await nc.publish(subject, pickle.dumps(message))

if __name__ == '__main__':
    asyncio.run(main())