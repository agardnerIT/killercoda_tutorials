## Preparation

Create a DT API token with the following permissions:

1. `releases.read` (v2: Read releases)

## Use Swagger

1) Open the `Environment API v2` definition in the tenant REST API browser.
2) Authorize with the your token.
3) Scroll down to the `Releases` endpoint

In the `releasesSelector` field use:

```
releasesProduct(product2),releasesStage(dev),releasesVersion(1.14.2)
```

Inspect the payload and notice the following:

1) The releases array contains all affected process group instances and their technology
2) The number of security vulnerabilities (if AppSec is enabled) per PGI
3) A high level indicator for each release of whether the release is currently impacted by a problem (`affectedByProblems`) or security vulnerabilities (`affectedBySecurityVulnerabilities`)

These fields rely on DAVIS to detect and report issues during releases.