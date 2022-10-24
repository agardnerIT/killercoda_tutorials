# Generate Docker Image

Generate a Docker image called `myfirstcontainer` at version `0.0.1` from the `Dockerfile`:

```
docker build -t myfirstcontainer:0.0.1 .
```{{exec}}

## Generate SBOM
Use Syft to generate a second SBOM, this time from the "as built" container image rather than the raw `Dockerfile`.

```
syft Dockerfile \
-o spdx-json \
--file sbom.dockerimage.json
```{{exec}}

You should now have two JSON files: `sbom.dockerfile.json` and `sbom.dockerimage.json`:

```
ls -l | grep .json
```{{exec}}