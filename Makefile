.PHONY: install iso

default: install
install:
	./install

VERSION=$(shell date +"%Y.%m").01
IMAGE=archlinux-${VERSION}-x86_64.iso
MIRROR=http://mirror.rackspace.com/archlinux/iso

iso:
	curl -o ${IMAGE} ${MIRROR}/${VERSION}/${IMAGE}
	curl -o ${IMAGE}.sig ${MIRROR}/${VERSION}/${IMAGE}.sig
	gpg --auto-key-retrieve --verify ${IMAGE}.sig
	# usrstuff
	mv ${IMAGE} ~/myd/sw/linux
	mv ${IMAGE}.sig ~/myd/sw/linux
