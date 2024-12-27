#!/bin/bash
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#


if [ -z  ${PLUGIN_GH_TOKEN} ]; then
    echo "ERROR: Please provide a valid github token in GH_TOKEN"
    exit 255
fi

if [ -z ${PLUGIN_GH_REPO} ]; then
    echo "ERROR: Please provide the full github repository name to mirror to"
    exit 255
fi

if [ -z ${PLUGIN_GH_REPO_DESC} ]; then
    echo "ERROR: Please provide a repository description for the github repo description"
    exit 255
fi

if [ -z ${PLUGIN_GH_REPO_HOMEPAGE} ]; then
    echo "ERROR: Please provide a homepage for the github repository"
    exit 255
fi

if [ -z ${PLUGIN_GH_REPO_TOPICS} ]; then
    echo "INFO: you can provide a list of github topics using the GH_REPO_TOPICS setting"
fi

echo ${PLUGIN_GH_TOKEN} | gh auth login --skip-ssh-key --with-token 


# we do nothing if the build is of a private repository
if [ "${DRONE_REPO_PRIVATE}" == "true" ]; then
    echo "WARNING: not mirroring private repositories. Did nothing."
    exit 0
fi


#check if repository already exist at gh otherwise create it
REPO_EXIST=$(gh repo view "${PLUGIN_GH_REPO}" >/dev/null;echo $?)

if [ $REPO_EXIST -ne 0 ]; then

    gh repo create "${PLUGIN_GH_REPO}" --public --disable-issues --disable-wiki

fi

# update repository data
gh repo edit -d "${PLUGIN_GH_REPO_DESC}" ${PLUGIN_GH_REPO}
gh repo edit -h "${PLUGIN_GH_REPO_HOMEPAGE}" ${PLUGIN_GH_REPO}

for t in ${PLUGIN_GH_REPO_TOPICS}; do 
    gh repo edit --add-topic "$t" "${PLUGIN_GH_REPO}"
done

# now push the current repository to github
gh auth setup-git

git push --all "https://github.com/${PLUGIN_GH_REPO}"

gh auth logout