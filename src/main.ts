import * as core from '@actions/core'

async function run(): Promise<void> {
  try {
    // const githubToken: string = core.getInput('GITHUB_TOKEN')
    const mapping: string     = core.getInput('mapping')

    core.debug(`The mapping is: ${mapping}`)
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
