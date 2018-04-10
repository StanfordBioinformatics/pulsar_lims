# -*- coding: utf-8 -*- 

###Author
#Nathaniel Watson
#2017-09-18
#nathankw@stanford.edu
###

import os
import json
import requests
import pdb

import inflection 

#pip install reflection.
#Ported from RoR's inflector.
#See https://inflection.readthedocs.io/en/latest/.

###Curl Examples 
#
# 1) Create a construct tag:
#
#    curl -X POST 
#       -d "construct_tags[name]=plasmid3" 
#       -H "Accept: application/json"
#       -H "Authorization: Token token=${TOKEN}" http://localhost:3000/api/construct_tags
#
# 2) Update the construct tag with ID of 3:
#
#     curl -X PUT
#       -d "construct_tag[name]=AMP"
#       -H "Accept: application/json"
#       -H "Authorization: Token token=${TOKEN}" http://localhost:3000/api/construct_tags/3"
#
# 2) Get a construct_tag:
#
#     curl -H "Accept: application/json"
#        -H "Authorization: Token token=${TOKEN}" http://localhost:3000/api/construct_tags/5
###

###Python examples using the 'requests' module
#
# HEADERS = {'content-type': 'application/json', 'Authorization': 'Token token={}'.format(TOKEN)}
# URL="http://localhost:3000/api/construct_tags"
# 1) Call 'index' method of a construct_tag:
#
#    requests.get(url=URL,headers=HEADERS, verify=False)
#
#  2) Call 'show' method of a construct_tags
#
#    >>>i requests.get(url=URL + "/1",headers=HEADERS, verify=False)
#
# 3) Create a new construct_tag
#
#    data = {'name': 'test_tag_ampc', 'description': "C'est bcp + qu'un simple ..."}
#    r = requests.post(url=url, headers=HEADERS, verify=False, data=json.dumps({"construct_tag": {"name": "nom"}}))



class Meta(type):
  def __init__(newcls,classname,supers,classdict):
    newcls.URL = os.path.join(newcls.URL,inflection.pluralize(newcls.MODEL_NAME))
     

class Model(metaclass=Meta):
  URL = os.environ["PULSAR_API_URL"]
  TOKEN = os.environ["PULSAR_TOKEN"]
  HEADERS = {'content-type': 'application/json', 'Authorization': 'Token token={}'.format(TOKEN)}
  MODEL_NAME = "" #subclasses define

  def record_url(self,uid):
    """
    Function : Given a record identifier, returns the URL to the record.
    Args     : uid - The database identifier of the record to fetch. Will be converted to a string.
    """
    uid = str(uid)
    return os.path.join(self.URL,uid)

  def delete(self,uid):
    """
    Function : Deletes the record. 
    Args     : uid - The database identifier of the record to fetch. Will be converted to a string.
    """
    url = self.record_url(uid)
    res = requests.delete(url=url,headers=self.HEADERS,verify=False)
    return res.json()
    
  def get(self,uid):
    """
    Function : Fetches a record by the records ID.
    Args     : uid - The database identifier of the record to fetch. Will be converted to a string. 
    """
    url = self.record_url(uid)
    res = requests.get(url=url,headers=self.HEADERS,verify=False)
    return res.json()

  def patch(self,uid, data):
    """
    Function : Patches the data to the specified record.
    Args     : uid - The database identifier of the record to patch. Will be converted to a string.
               data - hash. This will be JSON-formatted prior to sending the request.
    """
    url = self.record_url(uid)
    if not self.MODEL_NAME in data:
      data = {self.MODEL_NAME: data}
    res = requests.patch(url=url,data=json.dumps(data),headers=self.HEADERS,verify=False)
    return res

  def post(self, data):
    """
    Function : Posts the data to the specified record.
    Args     : uid - The database identifier of the record to fetch. Will be converted to a string.
               data - hash. This will be JSON-formatted prior to sending the request.
    """
    if not self.MODEL_NAME in data:
      data = {self.MODEL_NAME: data}
    return requests.post(url=self.URL,data=json.dumps(data),headers=self.HEADERS,verify=False)



class Antibody(Model):
  MODEL_NAME = "antibody"

class AntibodyPurification(Model):
  MODEL_NAME = "antibody_purification"

class Biosample(Model):
  MODEL_NAME = "biosample"

class BiosampleTermName(Model):
  MODEL_NAME = "biosample_term_name"
  
class ConstructTags(Model):
  MODEL_NAME = "construct_tag"
  
if __name__ == "__main__":
  #pdb.set_trace()
  b = Biosample()
  pdb.set_trace()
  res = b.get(uid=1716)
  #res = b.patch(uid=1772,data={"name": "bobq_a"})
  #res = b.delete(uid=1719)
  #c = ConstructTag()
  #res = c.post(data={"name": "howdy there partner"})  
  pdb.set_trace()
  
