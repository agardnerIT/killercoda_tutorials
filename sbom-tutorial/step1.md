# Generate an SBOM

A `Dockerfile` already exists. Show it now:

```
cat ~/Dockerfile
```{{exec}}

## Generate an SBOM with Syft
Use [Syft](https://github.com/anchore/syft) to generate an SBOM for this Dockerfile, saving the output in `spdx-json` format with the filename `sbom.dockerfile.json`

```
syft Dockerfile \
-o spdx-json \
--file sbom.dockerfile.json
```{{exec}}