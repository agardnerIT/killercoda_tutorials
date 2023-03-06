# Moving to a Full FF System

Code snippets...

## LaunchDarkly
```
import { init } from 'launchdarkly-node-server-sdk';
import { LaunchDarklyProvider } from '@launchdarkly/openfeature-node-server';

const ldClient = init('[YOUR-SDK-KEY]');
await ldClient.waitForInitialization();
OpenFeature.setProvider(new LaunchDarklyProvider(ldClient));
```

## flagd
```
OpenFeature.setProvider(new FlagdProvider({
    host: '[FLAGD_HOST]',
    port: 8013,
}))
```

etc.