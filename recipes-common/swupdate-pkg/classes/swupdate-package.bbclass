inherit swupdate

SWUPDATE_PACKAGES ?= ""

PACKAGE_BASENAME ?= "Packages"
PACKAGE_TYPE ?= "tar.gz"

PACKAGE_NAME = '${PACKAGE_BASENAME}.${PACKAGE_TYPE}'

IMAGE_NAME_colibri-imx7-rainbow = "Colibri-Imx7-Kunlun_${PACKAGE_BASENAME}"

def package_getdepends(d):
    def adddep(depstr, deps):
        for i in (depstr or "").split():
            if i not in deps:
                deps.append(i)

    deps = []
    packages = (d.getVar('SWUPDATE_PACKAGES', True) or "").split()
    for package in packages:
            adddep(package , deps)

    depstr = ""
    for dep in deps:
        depstr += " " + dep + ":do_build"
    return depstr


python () {
    deps = " " + package_getdepends(d)
    d.appendVarFlag('do_swuimage', 'depends', deps)
}

def read_pkgdatafile(fn):
    import codecs
    pkgdata = {}

    def decode(str):
        c = codecs.getdecoder("unicode_escape")
        return c(str)[0]

    if os.access(fn, os.R_OK):
        import re
        f = open(fn, 'r')
        lines = f.readlines()
        f.close()
        r = re.compile("([^:]+):\s*(.*)")
        for l in lines:
            m = r.match(l)
            if m:
                pkgdata[m.group(1)] = decode(m.group(2))

    return pkgdata

python do_swuimage_prepend() {

    import shutil
    pkg_dic = {}
    pkg_file_list = []

    packages = d.getVar('SWUPDATE_PACKAGES', True).split() 

    for pkg in packages:
        pkg_info = os.path.join(d.getVar('PKGDATA_DIR'),
                                'runtime', pkg)

        pkg_dic = read_pkgdatafile(pkg_info)
        ipkver = "%s-%s" % (pkg_dic['PKGV'], pkg_dic['PKGR'])
        ipk_name = "%s_%s_%s.ipk" % (pkg_dic['PKG_' + pkg], ipkver, d.getVar('PACKAGE_ARCH'))
        pkg_file_list.append(ipk_name)

    tar_files = ' '.join(pkg_file_list)

    if len(tar_files) > 1 :
        src_files = '%s file://%s/%s' % (d.getVar('SRC_URI'), d.getVar('WORKDIR', True), d.getVar('PACKAGE_NAME'))
        d.setVar('SRC_URI', src_files)

        bb.note(d.getVar('SRC_URI'))

        cmd = 'tar -cvzf %s/%s -C %s  %s' % (d.getVar('WORKDIR', True), d.getVar('PACKAGE_NAME'), d.getVar('DEPLOY_DIR_IPK') + '/' + d.getVar('PACKAGE_ARCH'), tar_files)
        os.system(cmd)
        bb.note('execute system command: ' + cmd)

        #workdir = d.getVar('WORKDIR', True)
        #s = d.getVar('S', True)
        #shutil.copyfile(os.path.join(workdir, d.getVar('PACKAGE_NAME')), os.path.join(s, d.getVar('PACKAGE_NAME')))
}

# addtask do_add_packages before do_swuimage