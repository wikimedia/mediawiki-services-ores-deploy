#!/bin/bash

# Point at deployed dirs.
deploy_dir="${SCAP_REV_PATH}"
venv="${deploy_dir}/venv"

# Install python libs.
cd $deploy_dir
mkdir -p $venv
virtualenv --python python3 --system-site-packages --never-download $venv
[ -f $deploy_dir/submodules/wheels/pip-*.whl ] && $venv/bin/pip install --no-deps $deploy_dir/submodules/wheels/pip-*.whl
$venv/bin/pip install --no-deps $deploy_dir/submodules/wheels/*.whl
