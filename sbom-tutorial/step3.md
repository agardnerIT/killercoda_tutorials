# Audit Dockerfile SBOM

[Grype](https://github.com/anchore/grype) is an open source tool to audit SBOM files. Use it to audit the SBOM generated from the `Dockerfile` in step 1.

```
grype sbom.dockerfile.json
```{{exec}}

The output should show...

```
 ✔ Vulnerability DB        [updated]
 ✔ Scanned image           [0 vulnerabilities]
No vulnerabilities found
```

# Audit Docker Image SBOM

Use [grype](https://github.com/anchore/grype) again.

This time audit the SBOM generate from the built docker image from step 2.

```
grype sbom.dockerimage.json
```{{exec}}

The output should show lots more vulnerabilities. As the container is now an artifact with lots of dependencies and libraries, the SBOM is much larger and thus the attack surface (potential for vulnerabilities) is much larger.

```
 ✔ Vulnerability DB        [no update available]
 ✔ Scanned image           [84 vulnerabilities]
NAME              INSTALLED           FIXED-IN     TYPE  VULNERABILITY     SEVERITY   
apt               2.2.4                            deb   CVE-2011-3374     Negligible  
bsdutils          1:2.36.1-8+deb11u1               deb   CVE-2022-0563     Negligible  
coreutils         8.32-4+b1                        deb   CVE-2017-18018    Negligible  
coreutils         8.32-4+b1           (won't fix)  deb   CVE-2016-2781     Low         
e2fsprogs         1.46.2-2            (won't fix)  deb   CVE-2022-1304     High
...
```