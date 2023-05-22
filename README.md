# Example of how to connect and use Elasticsearch on IBM Cloud Databases using bash automation and CURL commands

Example how to connect to [Elasticsearch](https://www.elastic.co/) on IBM Cloud with [Databases for Elasticsearch](https://cloud.ibm.com/databases/databases-for-elasticsearch) using bash scripting with cURL.

**Content:**

* Setup
* Example usage of search indexes using bash automation
* Elasticsearch example CURL search command

**Useful resources:**

* [Elasticsearch API documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) here you can easily copy the commands
* [IBM Cloud Elasticsearch `CURL` documentation](https://cloud.ibm.com/docs/databases-for-elasticsearch?topic=databases-for-elasticsearch-connecting-curl)

## 1. Setup

### Step 1: Clone the repo to the local machine

```sh
git clone https://github.com/thomassuedbroecker/example-connect-to-elastic-search
cd example-connect-to-elastic-search
```
### Step 2: Create a `Standard` Eleasticsearch instance on IBM Cloud

```sh
open https://cloud.ibm.com/databases/databases-for-elasticsearch/create
```

### Step 3: Create new Service Credentials

![](./images/elasticsearch-01.png)

### Step 4: Download the self-signed certificate to your local computer

Download the certificate file into the folder ./code/cert.

![](./images/elasticsearch-02.png)

### Step 5: Create a .env file for environment variables of the bash automation

```sh
cat code/.env_template > .env
```

### Step 6: Insert the needed values for the environment variables

```sh
# IBM Cloud
export IBM_CLOUD_API_KEY=XXXX
export IBM_CLOUD_REGION=us-south
export IBM_CLOUD_RESOURCE_GROUP=default

# Elasticsearch service
export E_SEARCH_SERVICE=YOUR_DatabasesForElasticsearch
export E_CERT_FILE_NAME=d5290bfc-XXXXX-XXX-9337-XXXX40bd
export E_HOST=XXXXX-XXXXX-XXXXX-XXXXX.XXXX.databases.appdomain.cloud
export E_PORT=0815
export E_ADMIN_USER=admin
export E_ADMIN_PASSWORD=YOUR_AWESOME_PASSWORD
```

### Step 7: Change the admin password for the database

```sh
cd /code
sh change_admin_password.sh
```

* Example output:

```sh
Key                   Value
ID                    crn:XXX
Deployment ID         crn:vXXX
Description           Updating user
Created At            2023-XX
Status                running
Progress Percentage   0
                      
Status                completed
Progress Percentage   100
Location              https://api.us-east.databases.cloud.ibm.com/XXXX
OK
```

## 2. Example usage of search indexes using bash automation

### Step 1: Test the connection

```sh
cd /code
sh test_connection.sh
```

* Example output:

```sh
{
  "cluster_name" : "XXX",
  "status" : "green",
 ...
}
```

### Step 2: Create indexes

```sh
cd /code
sh create_indexes.sh
```

* Example output:

```sh
Create: documents
HTTP/1.1 200 OK
content-type: application/json; charset=UTF-8
content-length: 85

{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "documents"
}
Create: passages
HTTP/1.1 200 OK
content-type: application/json; charset=UTF-8
content-length: 84

{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "passages"
}
```

### Step 3: Upload data to index

```sh
cd /code
sh upload-data_to_indexes.sh
```

* Example output:

```sh
[
  {
    "chunckid": "1.0815",
    "text": [
      "Hello world",
      "This is the first hello world example!"    ],
      "url": "http://example.com/docs/0001",
    "title": "Hello world"
  },
  {
    "chunckid": "1.0815",
    "text": [
      "This is the second hello world example!"    ],
      "url": "http://example.com/docs/0001",
    "title": "Hello world"
  }
]HTTP/1.1 200 OK
content-type: application/json; charset=UTF-8
content-length: 451

{"took":119,"errors":false,"items":[{"index":{"_index":"passages","_type":"_doc","_id":"http://example.com/docs/0001","_version":1,"result":"created","_shards":{"total":2,"successful":2,"failed":0},"_seq_no":0,"_primary_term":1,"status":201}},{"index":{"_index":"passages","_type":"_doc","_id":"http://example.com/docs/0001","_version":2,"result":"updated","_shards":{"total":2,"successful":2,"failed":0},"_seq_no":1,"_primary_term":1,"status":200}}]}Upload next file: /Users/thomassuedbroecker/Downloads/dev/example-connect-to-elastic-search/code/full/full1.json
[
    {
      "title": "Hello world",
      "url": "http://example.com/docs/0001",
      "text": [
        "Hello world",
        "This is the first hello world example!", 
        "This is the second hello world example!"      
       ]
    }
]HTTP/1.1 200 OK
content-type: application/json; charset=UTF-8
content-length: 245

{"took":117,"errors":false,"items":[{"index":{"_index":"documents","_type":"_doc","_id":"http://example.com/docs/0001","_version":1,"result":"created","_shards":{"total":2,"successful":2,"failed":0},"_seq_no":0,"_primary_term":1,"status":201}}]}
```

### Step 4: Search in index

```sh
cd /code
sh search_in_indexes.sh
```

### Step 5: Delete indexes

```sh
cd /code
sh delete_indexes.sh
```

## Elasticsearch example CURL search command

### Step 1: Open a terminal

### Step 2: Create a folder called cert

```sh
mkdir cert
```

### Step 3: Navigate to the folder 

```sh
cd cert
```

### Step 4: Set the environment variable path 

```sh
export E_CERT_PATH=$(pwd)
```

### Step 5: Download the certificate file for your [Databases for Elasticsearch](https://cloud.ibm.com/databases/databases-for-elasticsearch) instance 

Download the certificate file to your local computer into the newly created folder.

![](./images/elasticsearch-02.png)

### Step 5: Set the following environment variables to your values

* Example:

```sh
export E_CERT_FILE_NAME=d5290bfc-XXXXX-XXX-9337-XXXX40bd
export E_HOST=XXXXX-XXXXX-XXXXX-XXXXX.XXXX.databases.appdomain.cloud
export E_PORT=0815
export E_ADMIN_USER=admin
export E_ADMIN_PASSWORD=YOUR_AWESOME_PASSWORD
```

### Step 6: Execute an index search

```sh
CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} -XGET -H "Content-Type: application/json" "https://${E_HOST}:${E_PORT}/documents/_search" -d '{ "query": {"multi_match" : {"query" : "Second Hello World?","fields": ["title", "text"]}}}' | jq '.'
```

* Example output:

```sh
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:100   453  100   423  100    30   1193     84 --:--:-- --:--:-- --:--:--  1279
{
  "took": 1,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 1,
      "relation": "eq"
    },
    "max_score": 1,
    "hits": [
      {
        "_index": "documents",
        "_type": "_doc",
        "_id": "http://example.com/docs/0001",
        "_score": 1,
        "_source": {
          "title": "Hello world",
          "url": "http://example.com/docs/0001",
          "text": [
            "Hello world",
            "This is the first hello world example!",
            "This is the second hello world example!"
          ]
        }
      }
    ]
  }
}
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:  0     0    0     0    0     0      0      0 --:--:-- --:--:100   526  100   435  100    91   1264    264 --:--:-- --:--:-- --:--:--  1529
{
  "took": 7,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 1,
      "relation": "eq"
    },
    "max_score": 1.1918257,
    "hits": [
      {
        "_index": "documents",
        "_type": "_doc",
        "_id": "http://example.com/docs/0001",
        "_score": 1.1918257,
        "_source": {
          "title": "Hello world",
          "url": "http://example.com/docs/0001",
          "text": [
            "Hello world",
            "This is the first hello world example!",
            "This is the second hello world example!"
          ]
        }
      }
    ]
  }
}
```








