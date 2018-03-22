venv="/srv/deployment/ores/venv"
deploy_dir="/srv/deployment/ores/deploy"
cd $deploy_dir
git submodule sync
git submodule update --init
rm -rf $venv
mkdir -p $venv
virtualenv --python python3 --system-site-packages $venv
[ -f $deploy_dir/submodules/wheels/pip-*.whl ] && $venv/bin/pip install --use-wheel --no-deps $deploy_dir/submodules/wheels/pip-*.whl
$venv/bin/pip install --use-wheel --no-deps $deploy_dir/submodules/wheels/*.whl
sudo service celery-ores-worker restart
