# Sound Space
[![build container](https://github.com/ChicoState/sound-space/actions/workflows/build_test.yml/badge.svg)](https://github.com/ChicoState/sound-space/actions/workflows/build_test.yml)

# DEVELOPMENT

## to use docker
 - you must be in the parent dir soundspace/(you are here)
 - make sure to run `source .bashrc` while in soundspace dir
 - you must first run `bash docker_manage.sh setup`
 - once you have done this you can use docker with the `dm` command
 - usual deveelopment cycle should look something like this:
 - make change -> dm build -> dm up -> [localhost:8000](localhost:8000) -> dm kill

