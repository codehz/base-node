#!/bin/python
import re
import pyalpm
import sys

if len(sys.argv) == 1:
    sys.exit(1)
match_name = re.compile(r'^[a-zA-Z0-9-]+')
db = pyalpm.Handle("/", "/var/lib/pacman").get_localdb()
packages = set()
package_blacklist = {'systemd', 'audit', 'tzdata', 'texinfo', 'man-db', 'pacman'}
file_blacklist = [re.compile(r) for r in [
    '^usr/lib/systemd/',
    '^etc/audisp/',
    '^etc/audit/',
    '^etc/pam.d/',
    '^usr/lib/sysusers.d/'
    '^usr/share/man/',
    '^usr/lib/udev/',
    '^usr/share/doc/',
    '^usr/share/factory/',
    '^usr/share/gtk-doc/',
    '^usr/share/info/',
    '^dev/',
    '^tmp/',
    '^usr/share/terminfo/']]

def check_file(file):
    for item in file_blacklist:
        if item.match(file) is not None:
            return False
    return True


def iterate_package(package):
    if package in package_blacklist:
        return
    pkg = db.get_pkg(package)
    if pkg is None:
        grps = db.read_grp(package)
        if grps is None:
            return
        for dep in grps[1]:
            iterate_package(dep.name)
        return
    packages.add(package)
    direct_depends = map(lambda x: match_name.findall(x)[0], pkg.depends)
    for dep in direct_depends:
        iterate_package(dep)


files = set()

for target in sys.argv[1:]:
    iterate_package(target)

for package in packages:
    sys.stderr.write(package+"\n")
    pkg = db.get_pkg(package)
    files.update([file for file in pkg.files if check_file(file[0])])

file_list = [x[0] for x in files]
file_list.sort()

for file in file_list:
    print(file)
