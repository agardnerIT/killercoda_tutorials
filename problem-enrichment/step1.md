# Preparation

Create a DT API token with the following permissions:

1. `events.ingest` (Ingest events)
2. `WriteConfig` (Write configuration)

# Install OneAgent
Install a Dynatrace OneAgent and set the hostgroup to `at-demo-enrichment`.


# (optional) Forgotten to Set Host Group?
If you forgot to set the host group, run the following playbook:

```
ansible-playbook ~/playbooks/set-oneagent-host-group.yaml
```{{exec}}

# Create Auto Tag Rule

Create an auto-tag rule to tag this host with the host group:

```
ansible-playbook ~/playbooks/create-tag-rule.yaml
```{{exec}}

Click `Next` when you have verified the OneAgent is installed, connected to the SaaS tenant and correctly tagged.