import * as core   from '@actions/core'
import * as github from '@actions/github'
import * as yaml   from 'js-yaml'

async function run(): Promise<void> {
  try {
    const mapping = yaml.safeLoad(core.getInput('mapping'))
    const octokit = new github.GitHub(core.getInput('GITHUB_TOKEN'))

    const modifiedFiles = await octokit.repos.getCommit({
      owner: github.context.repo.owner,
      repo: github.context.repo.repo,
      ref: github.context.sha
    })

    core.error(`SHA`)
    console.log(github.context.sha)

    core.error(`TOH EL CONTEXT`)
    console.log(github.context)

    core.error(`Starting modified files:`)
    console.log(modifiedFiles)
    for (const user in mapping) {
      const paths = mapping[user]

      core.error(`The user "${user}" has the paths: ${paths}`)
    }
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
