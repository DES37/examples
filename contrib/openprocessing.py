#! /usr/bin/env python3

# Spencer Mathews, 11/2016
# Script to download code from OpenProcessing
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 

check md5 of zips downloaded with python!
may just want to use curl!

curl -O http://...  # -O same as --remote-name



import sys

print sys.executable

import os

print os.path.realpath(__file__)
#print os.__file__


sketch_id = '384396'

zip_url = 'https://www.openprocessing.org/sketch/'+sketch_id+'/download/sketch'+sketch_id+'.zip'

import requests


# http://stackoverflow.com/a/16696317/2762964
# http://stackoverflow.com/a/16695277/2762964
def download_file(url):
    local_filename = url.split('/')[-1]
    # NOTE the stream=True parameter
    r = requests.get(url, stream=True)
    with open(local_filename, 'wb') as f:
        for chunk in r.iter_content(chunk_size=1024): 
            if chunk: # filter out keep-alive new chunks
                f.write(chunk)
                #f.flush() commented by recommendation from J.F.Sebastian
                #os.fsync()
    return local_filename

# http://stackoverflow.com/a/39217788/2762964
import requests
import shutil
def download_file2(url):
    local_filename = url.split('/')[-1]
    r = requests.get(url, stream=True)
    with open(local_filename, 'wb') as f:
        shutil.copyfileobj(r.raw, f)
    return local_filename