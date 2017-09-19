
###Author
#Nathaniel Watson
#2017-09-18
#nathankw@stanford.edu
###

import os
import json
import requests
import pdb

###Curl Examples 
#
# 1) Create a construct tag:
#
#    curl -X POST 
#			 -d "construct_tags[name]=plasmid3" 
#			 -H 'Accept: application/json' 
#			 -H "Authorization: Token token=${TOKEN}" http://localhost:3000/api/construct_tags
#
# 2) Get a construct_tag:
#
#		 curl -H 'Accept: application/json'
#		 	 -H "Authorization: Token token=${TOKEN}" http://localhost:3000/api/construct_tags/5
###

###Python examples using the 'requests' module
#
# HEADERS = {'content-type': 'application/json', 'Authorization': 'Token token={}'.format(TOKEN)}
# URL="http://localhost:3000/api/construct_tags"
# 1) Call 'index' method of a construct_tag:
#
#		requests.get(url=URL,headers=HEADERS, verify=False)
#
#	2) Call 'show' method of a construct_tags
#
#		>>>i requests.get(url=URL + "/1",headers=HEADERS, verify=False)
#
# 3) Create a new construct_tag
#
#		data = {'name': 'test_tag_ampc', 'description': "C'est bcp + qu'un simple ..."}
#		r = requests.post(url=url, headers=HEADERS, verify=False, data=json.dumps({"construct_tag": {"name": "nom"}}))

class Model:
	TOKEN = os.environ["TOKEN"]
	HEADERS = {'content-type': 'application/json', 'Authorization': 'Token token={}'.format(TOKEN)}
	URL = os.environ["PULSAR_API_URL"]
	MODEL_NAME = "" #subclasses define

	def delete(self,uid):
		"""
		Function : Deletes the record. 
		Args     : uid - The database identifier of the record to fetch. Will be converted to a string.
		"""
		uid = str(uid)
		url = os.path.join(self.URL,uid)
		res = requests.delete(url=url,headers=self.HEADERS,verify=False)
		return res
		
	
	def get(self,uid):
		"""
		Function : Fetches a record by the records ID.
		Args     : uid - The database identifier of the record to fetch. Will be converted to a string. 
		"""
		uid = str(uid)
		url = os.path.join(self.URL,uid)
		res = requests.get(url=url,headers=self.HEADERS,verify=False)
		return res.json()

	def patch(self,uid, data):
		"""
		Function : Patches the data to the specified record.
		Args     : uid - The database identifier of the record to fetch. Will be converted to a string.
							 data - hash. This will be JSON-formatted prior to sending the request.
		"""
		uid = str(uid)
		url = os.path.join(self.URL,uid)
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
	URL = os.path.join(Model.URL,"antibodies")
	MODEL_NAME = "antibody"

class AntibodyPurification(Model):
	URL = os.path.join(Model.URL,"antibody_purifications")
	MODEL_NAME = "antibody_purification"

class Biosamples(Model):
	URL = os.path.join(Model.URL,"biosamples")
	MODEL_NAME = "biosample"

class Biosamples(Model):
	URL = os.path.join(Model.URL,"biosample_term_names")
	MODEL_NAME = "biosample_term_name"
	
class ConstructTags(Model):
	URL = os.path.join(Model.URL,"construct_tags")
	MODEL_NAME = "construct_tag"
	
if __name__ == "__main__":
	print("Starting")
	b = Biosamples()
	#res = b.get(uid=1772)
	#res = b.patch(uid=1772,data={"name": "Freddy"})
	res = b.delete(uid=1719)
	#c = ConstructTags()
	#res = c.post(data={"name": "howdy there partner"})	
	pdb.set_trace()
	
