#!/bin/sh -e

/usr/bin/push-ref-gitlab \
--build-events-webhook-url="${BUILD_EVENTS_WEBHOOK_URL}" \
--gitlab-instance="${GITLAB_INSTANCE_URL}" \
--github-repo-owner="${GITHUB_ACCOUNT}" \
--github-repo-path="${REPO_NAME}" \
--github-private-token="${GITHUB_TOKEN}" \
--gitlab-repo-owner="${GITLAB_ACCOUNT}" \
--ref="${REF}" \
--gitlab-token="${GITLAB_TOKEN}" \
--gitlab-runner-id="${GITLAB_CI_RUNNER_ID}" \
--cwd=/home/gitsync 2>&1
