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

Show the output of this file:

```
cat ~/sbom.dockerfile.json
```{{exec}}

Which should look like this:

```
{
 "SPDXID": "SPDXRef-DOCUMENT",
 "name": "Dockerfile",
 "spdxVersion": "SPDX-2.2",
 "creationInfo": {
  "created": "2022-01-01T00:00:00.12341234Z",
  "creators": [
   "Organization: Anchore, Inc",
   "Tool: syft-0.59.0"
  ],
  "licenseListVersion": "3.18"
 },
 "dataLicense": "CC0-1.0",
 "documentNamespace": "https://anchore.com/syft/file/Dockerfile-b3e8946a-1bc8-4041-a22c-d0a26b6234b8",
 "packages": []
}
```

The key part is the `packages` list. Syft doesn't see any other dependencies.