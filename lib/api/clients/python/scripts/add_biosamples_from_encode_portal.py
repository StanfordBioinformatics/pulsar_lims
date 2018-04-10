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

# Note that ex_url below has a double '%', where the second is used to escape the original. 
ex_url = "https://www.encodeproject.org/search/?type=Biosample&lab.title=Michael+Snyder%%2C+Stanford&award.rfa=ENCODE4&biosample_type=tissue"

def get_parser():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument("-u", "--url", required=True, help="""
    A search URL to indicate which biosamples to import, i.e. {}.""".format(ex_url))
    return parser

def main():
    parser = get_parser()
    args = parser.parse_args()
    url = args.url
    conn = Connection("prod")
    res = conn.search(url=url)
    for i in res: # i is a JSON object.
        # GET the object. Only part of the object is given in the search results. For example, 
        # the property 'genetic_modifications' isn't present. 
        rec_id = res["@id"]
        jso_rec = conn.get(rec_id)

if __name__ == "__main__":
    main()
