#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import csv

def snf_path(root,path):
    return os.path.join(root,"_snf",path)

def csv2dict(path,name):
    csv_reader = csv.reader(open(snf_path(path,name)))
    dic = {}
    for row in csv_reader:
        dic[row[0]] = row[1:]
    return dic

def dict2csv(dic,path,name):
    import copy
    csv_writer = csv.writer(open(snf_path(path,name),'w'))
    for k,v in dic.items():
        row = copy.copy(v)
        row.insert(0, k)
        csv_writer.writerow(row)

def load(path):
    return csv2dict(path,"cache.csv"), csv2dict(path,"config.csv")

def get_newname(cache, config, offset):
    n = int(cache["last"][0]) + offset
    return config["temp"][0] % n , n

def main(opts,args):
    if len(args) > 0:
        num = int(args[0])
    else:
        num = 1

    if opts.makenew:
        snfpath = snf_path(opts.path,"")
        if not os.path.isdir(snfpath):
            os.mkdir(snfpath)
        cache  = dict(last=[-1])
        config = dict(temp=[opts.temp])
        dict2csv(cache, opts.path, "cache.csv")
        dict2csv(config,opts.path,"config.csv")
        return 0

    if not os.path.isdir(snf_path(opts.path,"")):
        return "Please make '_snf' directory using -n and -m options."

    cache, config = load(opts.path)
    for i in xrange(1,num+1):
        name, n = get_newname(cache,config,i)
        os.system( opts.callback % name )

    if not opts.test:
        cache["last"][0] = str(n)
        dict2csv(cache,opts.path,"cache.csv")

    return 0

if __name__ == '__main__':
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-t", "--test", dest="test", default=False, action="store_true",
                      help="do not increment sequence numbers.")
    parser.add_option("-p", "--path", dest="path", default="./",
                      help="working directory path.", metavar="PATH")
    parser.add_option("-n", "--makenew", dest="makenew", default=False, action="store_true",
                      help="make new '_snf' for creating.")
    parser.add_option("-m", "--temp", dest="temp", default="snf_05%d",
                      help="template string for making new '_snf/config.csv'.", metavar="STR")
    parser.add_option("-c", "--callback", dest="callback", default="echo %s",
                      help="callback system command. '%s' will be changed to snf filename.", metavar="STR")
    (opts, args) = parser.parse_args()

    import sys
    msg = main(opts, args)
    sys.exit(msg)
