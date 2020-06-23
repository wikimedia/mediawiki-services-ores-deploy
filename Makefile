# Requires that a virtualenv has been activated.
# FIXME: Should assert as much.

REQUIREMENTS_FILES = \
	submodules/articlequality/requirements.txt \
	submodules/draftquality/requirements.txt \
	submodules/drafttopic/requirements.txt \
	submodules/editquality/requirements.txt \
	submodules/ores/requirements.txt \
	requirements.txt

# FIXME: setuptools somehow isn't omitted.
OMIT_WHEELS = \
	articlequality \
	draftquality \
	drafttopic \
	editquality \
	ores \
	pkg-resources \
	setuptools

.DEFAULT_GOAL := all

all: clean_env clean_wheels_dir deployment_wheels

clean_env:
	PURGE_PKGS=`pip freeze | grep -vwE -- "-e|pkg-resources"`; \
	if [ -n "$$VIRTUAL_ENV" -a "$$PURGE_PKGS" ]; then \
	  echo "$$PURGE_PKGS" | xargs pip uninstall -y; \
	fi

pip_install:
	pip install wheel && \
	pip install --upgrade pip && \
	for req_txt in $(REQUIREMENTS_FILES); do \
	  pip install -r $$req_txt; \
	done

frozen-requirements.txt: pip_install
	pip freeze | \
	  grep -v $(addprefix -e , $(OMIT_WHEELS)) > \
	frozen-requirements.txt

deployment_wheels: frozen-requirements.txt
	mkdir -p wheels && \
        rm wheels/*.whl -f && \
	pip wheel -r frozen-requirements.txt -w wheels
