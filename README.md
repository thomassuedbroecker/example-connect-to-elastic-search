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




