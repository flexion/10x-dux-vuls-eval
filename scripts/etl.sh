#!/usr/bin/env sh

export PATH=/usr/local/bin:${PATH}
export NVD_YEARS=${NVD_YEARS:-"$(seq 2002 $(date +"%Y"))"}
export GO_EXPLOITDB_SOURCES="exploitdb"
export GOST_LINUX_DISTROS="debian redhat"
export OVAL_ALPINE_VERSIONS=${OVAL_ALPINE_VERSIONS:-"3.3 3.4 3.5 3.6 3.7 3.8 3.9 3.10 3.11 3.12"}
export OVAL_AMAZON_VERSIONS=${OVAL_AMAZON_VERSIONS:-""}
export OVAL_DEBIAN_VERSIONS=${OVAL_DEBIAN_VERSIONS:-"8 9 10"}
export OVAL_REDHAT_VERSIONS=${OVAL_REDHAT_VERSIONS:-"6 7 8"}
export OVAL_UBUNTU_VERSIONS=${OVAL_UBUNTU_VERSIONS:-"16 18 20"}

for y in $NVD_YEARS; do \
    echo Load go-cve-dictionary data for year $y ...
    go-cve-dictionary fetchnvd ${@} -years $y; \
done

for s in $GO_EXPLOITDB_SOURCES; do \
    echo Load go-exploitdb data source $s ...
    # go-exploitdb does not support single hyphens, two required
    go-exploitdb fetch ${@//-db/--db} $s; \
done

for d in $GOST_LINUX_DISTROS; do \
    echo Load gost data for distro $d ...
    # gost does not support single hyphens, two required
    gost fetch ${@//-db/--db} $d; \
done

echo Load go-msfdb data ...
# go-msfdb does not support single hyphens, two required
go-msfdb fetch ${@//-db/--db} msfdb

echo Load goval-dictionary data for Alpine Linux $OVAL_ALPINE_VERSIONS ...
goval-dictionary fetch-alpine ${@} $OVAL_ALPINE_VERSIONS
echo Load goval-dictionary data for Amazon Linux $OVAL_AMAZON_VERSIONS ...
goval-dictionary fetch-amazon ${@} $OVAL_AMAZON_VERSIONS
echo Load goval-dictionary data for Debian Linux $OVAL_DEBIAN_VERSIONS ...
goval-dictionary fetch-debian ${@} $OVAL_DEBIAN_VERSIONS
echo Load goval-dictionary data for RedHat Linux $OVAL_REDHAT_VERSIONS ...
goval-dictionary fetch-redhat ${@} $OVAL_REDHAT_VERSIONS
echo Load goval-dictionary data for Ubuntu Linux $OVAL_UBUNTU_VERSIONS ...
goval-dictionary fetch-ubuntu ${@} $OVAL_UBUNTU_VERSIONS