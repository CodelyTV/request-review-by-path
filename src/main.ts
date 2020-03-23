import * as core   from '@actions/core'
import * as github from '@actions/github'
import * as yaml   from 'js-yaml'

async function run(): Promise<void> {
  function isInside(filename: string, paths: Array<string>): boolean {
    return paths.some(path => filename.startsWith(path))
  }

  try {
    const mapping = yaml.safeLoad(core.getInput('mapping'))
    const octokit = new github.GitHub(core.getInput('GITHUB_TOKEN'))

    const modifiedFilenames = (await octokit.repos.getCommit({
      owner: github.context.repo.owner,
      repo: github.context.repo.repo,
      ref: github.context.payload.after
    })).data.files.map(file => file.filename)

    for (const user in mapping) {
      const paths = mapping[user]

      core.error(`The user "${user}" has the paths: ${paths}. And modified are ${modifiedFilenames}`)

      if (modifiedFilenames.some(filename => isInside(filename, paths))) {
        core.error(`PR IS GONNA BE ASSIGNED`)
      } else {
        core.error(`PR IS NOOOOT GONNA BE ASSIGNED`)
      }
    }
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
