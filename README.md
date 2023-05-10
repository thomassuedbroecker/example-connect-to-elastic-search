# example-connect-to-elastic-search

Example how to connect to Elasticsearch on IBM Cloud using bash scripting.

* [Elasticsearch API documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) here you can easily copy the commands
* [IBM Cloud Elasticsearch `CURL` documentation](https://cloud.ibm.com/docs/databases-for-elasticsearch?topic=databases-for-elasticsearch-connecting-curl)

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

Download the certificate into the folder ./code/cert.

### Step 5: Create a .env file for environment variables of the bash automation

```sh
cat code/.env_template > .env
```

### Step 6: Insert the needed values for the environment variables

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

### Step 7: Change the admin password for the database

```sh
cd /code
sh change_admin_password.sh
```

### Step 8: Test the connection

```sh
cd /code
sh test_connection.sh
```

### Step 9: Create indexes

```sh
cd /code
sh create_indexes.sh
```

### Step 10: Upload data to index

```sh
cd /code
sh upload-data_to_indexes.sh
```

### Step 11: Search in index

```sh
cd /code
sh search_in_indexes.sh
```

### Step 12: Delete indexes

```sh
cd /code
sh delete_indexes.sh
```

