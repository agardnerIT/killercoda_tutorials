# Generate Docker Image

Generate a Docker image called `myfirstcontainer` at version `0.0.1` from the `Dockerfile`:

```
docker build -t myfirstcontainer:0.0.1 .
```{{exec}}

## Generate SBOM
Use Syft to generate a second SBOM, this time from the "as built" container image rather than the raw `Dockerfile`.

```
syft myfirstcontainer:0.0.1 \
-o spdx-json \
--file sbom.dockerimage.json
```{{exec}}

The output should now show `✔ Cataloged packages [108 packages]`.

You should now have two JSON files: `sbom.dockerfile.json` and `sbom.dockerimage.json`:

```
ls -l | grep .json
```{{exec}}