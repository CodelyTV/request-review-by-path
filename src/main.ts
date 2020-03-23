import * as core from '@actions/core'
import * as yaml from 'js-yaml'


async function run(): Promise<void> {
  try {
    // const githubToken: string = core.getInput('GITHUB_TOKEN')
    const mapping = yaml.safeLoad(core.getInput('mapping'))

    core.error(`some message`)
    core.error(`The mapping is: ${mapping}`)
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
