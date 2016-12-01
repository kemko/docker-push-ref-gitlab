#!/bin/sh -e

GITLAB_STATE="$1"
BUILD_ID="$2"
SHA="$3"
BUILD_STAGE="$4"
REPOSITORY="$5"

# Determine GitHub state
if [ "${GITLAB_STATE}" = "created" ] || [ "${GITLAB_STATE}" = "running" ] || [ "${GITLAB_STATE}" = "pending" ]; then
        GITHUB_STATE="pending"
elif [ "${GITLAB_STATE}" = "success" ]; then
        GITHUB_STATE="success"
elif [ "${GITLAB_STATE}" = "failed" ]; then
        GITHUB_STATE="failure"
else
        echo "Unknown GitLab state: ${GITLAB_STATE}"
        exit 1
fi

BUILD_URL="${GITLAB_INSTANCE_URL}"/"${GITLAB_ACCOUNT}"/"${REPOSITORY}"/builds/"${BUILD_ID}"

PAYLOAD="{\"state\":\"${GITHUB_STATE}\",\"target_url\":\"${BUILD_URL}\",\"context\":\"${BUILD_STAGE}\"}"

curl -d "$PAYLOAD" -u "${GITHUB_ACCOUNT}":"${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_ACCOUNT}/${REPOSITORY}/statuses/${SHA}
