#!/usr/bin/env python3                                                                                 
# -*- coding: utf-8 -*-                                                                                
                                                                                                       
###                                                                                                    
# © 2018 The Board of Trustees of the Leland Stanford Junior University                                
# Nathaniel Watson                                                                                     
# nathankw@stanford.edu                                                                                
###

"""
Backports biosamples from the ENCODE Portal. A search URL for the ENCODE Portal must be given
in order to designate which biosamples to backport.  
"""

import argparse

from encode_utils.connection import Connection

def get_parser():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument("-u", "--url", required=True, help="""
    A search URL to indicate which biosamples to import, i.e.'https://www.encodeproject.org/search/?type=Biosample&lab.title=Michael+Snyder    %%2C+Stanford&award.rfa=ENCODE4&biosample_type=tissue'.""")
    return parser

def main():
    parser = get_parser()
    args = parser.parse_args()
    url = args.url
    conn = Connection("prod")
    res = conn.search(url=url)

if __name__ == "__main__":
    main()
