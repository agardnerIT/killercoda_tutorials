## Inspect the Pyrsia transparency log

Now, let's take a look at the transparency logs.

Next, let's take the alpine:3.16.2 example again:

```
pyrsia inspect-log docker --image alpine:3.16.2
```{{exec}}

This CLI command returns the transparency logs for all the Pyrsia artifacts that make up the Docker image `alpine:3.16.2`:

```
[
  {
    "id": "cc3dec20-8604-4d0a-8c18-ccb746769696",
    "package_type": "Docker",
    "package_specific_id": "alpine:3.16.2",
    "num_artifacts": 4,
    "package_specific_artifact_id": "alpine:3.16.2",
    "artifact_hash": "1304f174557314a7ed9eddb4eab12fed12cb0cd9809e4c28f29af86979a3c870",
    "source_hash": "",
    "artifact_id": "75c7bd83-1dd4-4666-a35f-e8c59b695e21",
    "source_id": "7ec06216-b2dc-4e5a-a90d-7875fb77b846",
    "timestamp": 1660906467,
    "operation": "AddArtifact",
    "node_id": "64765410-136b-4332-a837-226bd062ba37",
    "node_public_key": "558b0373-a29d-40c9-8125-019fb74dda31"
  },
  {
    "id": "d88982b1-261b-4e3d-9eb2-dd549c40ac05",
    "package_type": "Docker",
    "package_specific_id": "alpine:3.16.2",
    "num_artifacts": 4,
    "package_specific_artifact_id": "alpine@sha256:1304f174557314a7ed9eddb4eab12fed12cb0cd9809e4c28f29af86979a3c870",
    "artifact_hash": "1304f174557314a7ed9eddb4eab12fed12cb0cd9809e4c28f29af86979a3c870",
    "source_hash": "",
    "artifact_id": "f2648155-b665-4567-9e3c-27af7cc3b9bb",
    "source_id": "0ca693f9-7c50-4448-9cd6-0d7a145fba14",
    "timestamp": 1660906529,
    "operation": "AddArtifact",
    "node_id": "60b7d9ae-d5ba-4440-ab83-6c5638a18a45",
    "node_public_key": "4a873a2a-0e04-4540-b1bd-bccc0d721ed2"
  },
  {
    "id": "f53f9cc6-6998-470a-8094-cae3fbc82412",
    "package_type": "Docker",
    "package_specific_id": "alpine:3.16.2",
    "num_artifacts": 4,
    "package_specific_artifact_id": "alpine@sha256:213ec9aee27d8be045c6a92b7eac22c9a64b44558193775a1a7f626352392b49",
    "artifact_hash": "213ec9aee27d8be045c6a92b7eac22c9a64b44558193775a1a7f626352392b49",
    "source_hash": "",
    "artifact_id": "dac2e42c-fd48-4487-b48c-34f5eac1f674",
    "source_id": "eed938e9-9cf8-4e1b-995f-6a6d1da6ef26",
    "timestamp": 1660906589,
    "operation": "AddArtifact",
    "node_id": "1e3244e3-1fc5-429b-8cc6-43dbbebaccb2",
    "node_public_key": "7d7d96c0-1b8b-4028-bb20-df9a45eeaa7f"
  },
  {
    "id": "cae2f5a7-22ec-4d22-86af-59e1f0239056",
    "package_type": "Docker",
    "package_specific_id": "alpine:3.16.2",
    "num_artifacts": 4,
    "package_specific_artifact_id": "alpine@sha256:9c6f0724472873bb50a2ae67a9e7adcb57673a183cea8b06eb778dca859181b5",
    "artifact_hash": "9c6f0724472873bb50a2ae67a9e7adcb57673a183cea8b06eb778dca859181b5",
    "source_hash": "",
    "artifact_id": "3fc0ac72-8f5e-41fe-8ab6-94c565ebc52c",
    "source_id": "4cb49c33-af4c-4c3a-8053-b771007a6720",
    "timestamp": 1660906649,
    "operation": "AddArtifact",
    "node_id": "64d30c8e-d356-420c-ab87-e27687ca6f1d",
    "node_public_key": "57130e5d-d0dc-450b-b80d-966cb71210ef"
  }
]
```{{copy}}