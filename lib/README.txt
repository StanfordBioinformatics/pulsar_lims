Nathaniel Watson
August 21, 2016

The seed data for populating the Vendor table is in the file named encode_sources.json. This file was acquired using the following command line using the script getJsonFromEncodeUrl.py within the git repository git@github.com:StanfordBioinformatics/encode.git:

python getJsonFromEncodeUrl.py --dcc-mode prod --dcc-user-name nathankw --url "https://www.encodeproject.org/sources/?format=json&limit=all" --outfile encode_sources.json

