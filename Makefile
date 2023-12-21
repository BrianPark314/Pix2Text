package:
	rm -rf build
	python setup.py sdist bdist_wheel

VERSION := $(shell sed -n "s/^__version__ = '\(.*\)'/\1/p" pix2text/__version__.py)
upload:
	python -m twine upload  dist/pix2text-$(VERSION)* --verbose

# 开启 OCR HTTP 服务
serve:
	p2t serve -p 8503 --reload

# 开启监控截屏文件夹的守护进程
daemon:
	python scripts/screenshot_daemon.py

docker-build:
	docker build -t breezedeus/pix2text:v$(VERSION) .

.PHONY: package upload serve daemon
