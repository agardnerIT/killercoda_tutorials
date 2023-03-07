import express from 'express'
import Router from 'express-promise-router'
import cowsay from 'cowsay'
import { OpenFeature } from '@openfeature/js-sdk'
import { MinimalistProvider } from '@moredip/openfeature-minimalist-provider'

const app = express()
const routes = Router();
app.use(routes);

const featureFlags = OpenFeature.getClient()
// This simulates a real feature flag backend database, file or SaaS provider
const FLAG_CONFIGURATION = {
  'with-cows':false
}

const featureFlagProvider = new MinimalistProvider(FLAG_CONFIGURATION)

OpenFeature.setProvider(featureFlagProvider)

routes.get('/', async (req, res) => {
  const withCows = await featureFlags.getBooleanValue('with-cows', false)
  if(withCows){
    res.send(cowsay.say({text:'Hello, world!'}))
  }else{
    res.send("Hello, world!")
  }
})

app.listen(3333)