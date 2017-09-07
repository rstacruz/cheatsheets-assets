
const CONFIG = {
  viewwidth: 1280,
  viewheight: (1280 / 1.91) | 0
}

/*
 * Run things
 */

async function run (opts) {
  const width = CONFIG.viewwidth
  const height = CONFIG.viewheight

  const debug = require('debug')(`images:${opts.sheet}`)

  const puppeteer = require('puppeteer')
  const url = opts.sheet

  debug('Fetching')
  const browser = await puppeteer.launch()

  // debug('Browser launched')
  const page = await browser.newPage()

  // debug('Setting viewport')
  await page.setViewport({ width, height })

  // debug('Going to URL')
  await page.goto(url)

  // debug('Taking screenshot')
  await page.screenshot({
    path: opts.output,
    x: 0,
    y: 45,
    width, height
  })

  debug('OK')
  browser.close()
}

module.exports = { run }
