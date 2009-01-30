#!/usr/bin/env python
# -*- coding: utf-8 -*-
import jinja
import os
import codecs
import yaml
import re

#--- guess encoding of string from pattern 'coding: ***'
re_coding = re.compile('coding *: *(.+)[ \n]')
def guess_encoding(string, default='utf-8' ):
    _re_coding = re_coding
    import re
    try: # to estimate coding
        encoding = _re_coding.search(string).group(1)
    except AttributeError:
        encoding = default
    return encoding

from optparse import OptionParser
parser = OptionParser()
parser.add_option(
    "-y", "--yaml", dest="yfile",
    default=None, metavar="FILE", help="yaml file.")
parser.add_option(
    "-j", "--jinja", dest="jfile",
    help="jinja file.", metavar="FILE")
parser.add_option(
    "-f", "--flags", dest="flag",
    default=None, metavar="FLAG", help="ex) -f name1:flag1,name2:flag2")
parser.add_option(
    "-i", "--jinja_coding", dest="jcoding",
    default=None, metavar="CODING",
    help="coding of jinja file. try to estimate if not specified." )
parser.add_option(
    "-d", "--out_file", dest="ofile",
    default=None, metavar="CODING",
    help=("output file name. if yaml has more than one data, "
          "the file name has suffix.") )
parser.add_option(
    "-o", "--out_coding", dest="ocoding",
    default=None, metavar="CODING",
    help="coding of output file." )

(opts, args) = parser.parse_args()

#--- guess jinja file encoding
jstr_unknown = open(opts.jfile, 'rb').read()
if opts.jcoding is not None:
    jcoding = opts.jcoding
else:
    jcoding = guess_encoding(jstr_unknown)
jstr = unicode( jstr_unknown, jcoding )

#--- get jinja template
env = jinja.Environment()
tmp = env.from_string( jstr )

#--- get yaml data
if opts.yfile is not None:
    yaml_data = yaml.load( file(opts.yfile) )
else:
    yaml_data = None

#--- set writer
if opts.ofile is None:
    def write_out(string):
        import sys
        codecs.getwriter('utf-8')(sys.stdout).write(string)
else:
    def write_out(string):
        ## print "outfile: ", outfile
        if opts.ocoding is not None:
            ocoding = opts.ocoding
        else:
            ocoding = guess_encoding(string)
        ## print "  coding: ", ocoding
        codecs.open(opts.ofile, 'w', ocoding).write(string)

#--- flag
if opts.flag is not None:
    flag = dict( [ [i.strip() for i in nf.split(":")] 
                   for nf in opts.flag.split(",")
                   ] )
else:
    flag = None

#--- generate and write
data = dict(
    arg = args,
    flg = flag,
    yml = yaml_data
    )
write_out( tmp.render(data) )


if opts.ofile is None:
    print
