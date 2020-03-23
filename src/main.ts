import * as core from '@actions/core'
import * as yaml from 'js-yaml'


async function run(): Promise<void> {
  try {
    // const githubToken: string = core.getInput('GITHUB_TOKEN')
    const mapping = yaml.safeLoad(core.getInput('mapping'))

    core.error(`Starting`)
    for (let user in mapping) {
      const paths = mapping[user]

      core.error(`The user "${user}" has the paths: ${paths}`)
    }
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
