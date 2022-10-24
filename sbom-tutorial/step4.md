# Audit Dockerfile SBOM

Use [grype](https://github.com/anchore/grype) again.

This time audit the SBOM generate from the built docker image from step 2.

```
grype sbom.dockerimage.json
```{{exec}}

The output should show lots more vulnerabilities. As the container is now an artifact with lots of dependencies and libraries, the SBOM is much larger and thus the attack surface (potential for vulnerabilities) is much larger.