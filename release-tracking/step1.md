## Preparation

Create a DT API token with the following permissions:

1. `DataExport` (v1: Access problem and event feed, metrics, and topology)
2. `ReadConfig` (v1: Read configuration)
3. `WriteConfig` (v1: Write configuration)
4. `settings.read` (v2: Read settings)
5. `settings.write` (v2: Write settings)
6. `entities.read` (v2: Read entities)
7. `InstallerDownload` (PaaS scope)

## Install OneAgent
Install a Dynatrace OneAgent and set the hostgroup to `at-demo-release`.


## (optional) Forgotten to Set Host Group?
If you forgot to set the host group, run the following playbook:

```
ansible-playbook ~/playbooks/set-oneagent-host-group.yaml
```{{exec}}

You should already have an auto tag rule created from the previous tutorial. Ensure your host is tagged as `at-host-group: at-demo-release`.

Click `Next` when you have verified the OneAgent is installed, connected to the SaaS tenant and correctly tagged.