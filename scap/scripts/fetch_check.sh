#!/bin/bash -x

# Point at deployed dirs.
deploy_dir="${SCAP_REV_PATH}"
venv="${deploy_dir}/venv"
venv_old=/srv/deployment/ores/venv

# Pull submodules.
cd $deploy_dir
git submodule sync
git submodule update --init

# Install python libs.
mkdir -p $venv
virtualenv --python python3 --system-site-packages $venv
[ -f $deploy_dir/submodules/wheels/pip-*.whl ] && $venv/bin/pip install --use-wheel --no-deps $deploy_dir/submodules/wheels/pip-*.whl
$venv/bin/pip install --use-wheel --no-deps $deploy_dir/submodules/wheels/*.whl

# Install redundant libs in the old path
mkdir -p $venv_old
virtualenv --python python3 --system-site-packages $venv_old
[ -f $deploy_dir/submodules/wheels/pip-*.whl ] && $venv_old/bin/pip install --use-wheel --no-deps $deploy_dir/submodules/wheels/pip-*.whl
$venv_old/bin/pip install --use-wheel --no-deps $deploy_dir/submodules/wheels/*.whl

# Force failure in order to print output
exit 1
