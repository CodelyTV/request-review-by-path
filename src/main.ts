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

    const usersToAssign = Object.keys(mapping).filter((user: string) => {
      const paths = mapping[user]

      return modifiedFilenames.some(filename => isInside(filename, paths))
    }).filter(user => user != github.context.actor)

    await octokit.pulls.createReviewRequest({
      owner: github.context.repo.owner,
      repo: github.context.repo.repo,
      reviewers: usersToAssign,
      pull_number: github.context.issue.number
    })
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
