import { serve } from '@hono/node-server'
import { Hono } from 'hono'

const app = new Hono()

app.get('/ping', (c) => {
  return c.json({message:"Hello world"})
})
  

app.get("/platform", (c) => {
  return c.json({
    platform: process.platform
  })
})
  
app.get("/college", (c) => {
  return c.json({
    college: "Siddagnaga Institute of technology",
    address: "BH road tumkur",
    pincode: "572103"
  })
})
serve({
  fetch: app.fetch,
  port: 3000
}, (info) => {
  console.log(`Server is running on http://localhost:${info.port}`)
})