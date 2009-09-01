#!/usr/bin/env python
# -*- coding: utf-8 -*-

import h5py
indent_depth = 2
ispace = ' ' * indent_depth

from optparse import OptionParser
parser = OptionParser()
parser.add_option("-v", "--value", dest="value", default=False,
                  action="store_true",
                  help="see values.")

(opts, args) = parser.parse_args()

def see_attrs(item, indent=0):
    sp0 = ispace * indent
    sp = ispace * (indent+1)
    print "%s_attrs:" % sp0
    for name, value in item.attrs.iteritems():
        print "%s%s: %s" % (sp, name, str(value))

def see_dataset(dset, indent=0):
    sp0 = ispace * indent
    print "%s_dtype: %s" % (sp0, str(dset.dtype))
    print "%s_shape: %s" % (sp0, str(dset.shape))
    if opts.value:
        print "%s_data:" % sp0
        sp = ispace * (indent+1)
        vstr = str(dset.value)
        print "\n".join([sp + vi for vi in vstr.split('\n')])
 
def see_group(group, indent=0):
    sp = ispace * indent
    for (name, value) in group.iteritems():
        if isinstance(value,h5py.Dataset):
            print "%s%s:" % (sp, name)
            see_attrs(value, indent+1)
            see_dataset(value, indent+1)
        elif isinstance(value,h5py.Group):
            print "%s%s:" % (sp, name)
            see_attrs(value, indent+1)
            see_group(value, indent+1)
 
def see_hdf5(path):
    f = h5py.File(path)
    see_group(f)
    f.close()
 
if __name__ == '__main__':
    see_hdf5(args[0])
