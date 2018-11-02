FROM kubevirt/libvirt:latest

RUN mkdir /tmp

RUN dnf install -y qemu vagrant \
&& dnf clean all
RUN vagrant plugin install vagrant-libvirt

COPY Vagrantfile /tmp
