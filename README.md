# example-connect-to-elastic-search

Example how to connect to Elasticsearch on IBM Cloud using bash scripting.

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

### Step 4: Create a .env file for environment variables of the bash automation

```sh
cat code/.env_template > .env
```

### Step 5: Insert the needed values for the environment variables

```sh
# IBM Cloud
export IBM_CLOUD_API_KEY=
export IBM_CLOUD_REGION=
export IBM_CLOUD_RESOURCE_GROUP=

# Elasticsearch service
export E_SEARCH_SERVICE=YOUR_DatabasesForElasticsearch
export E_PORT=YOUR_PORT
export E_HOST=YOUR_HOST
export E_CERT_FILE_NAME=
export E_CERT_PATH=$HOME_PATH/cert
export E_ADMIN_USER=admin
export E_ADMIN_PASSWORD=YOUR_PASSWORD
```


