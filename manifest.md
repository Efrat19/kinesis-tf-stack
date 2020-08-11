## Y2 event streaming
##### High level technical design
https://cloudcraft.co/app/blueprint/45c00f19-8253-46a0-8043-4989917fa793

---
##### Goal
- switch from legacy system to a new cloud-native highly-available event-streaming system
- implement an event-sourcing design pattern to increase flexibilty and prevent transactions data loss

##### Risks
- eventual consistency

##### Legacy system
- Functionality:
    - upadting Elasticsearch according to state chages. 
- Overview:
    - db trigger is writing to the listing-delta table on every change to various tables
    - a custom cronjob (listing-delta) scans that table and updates Elasticsearch accordingy
- system components:
    - self-hosted service running as a job every 5 minutes 
- problems:
    1. insufficient support for deletion events
    2. overuse of computing-resources at peak hours
    3. lost of transaction data - only the state is preserved
    4. lack of support for future data consumers rather than Elasticsearch
    5. hard to maintain, cloud incompatible architecture
    
##### New system
- Functionality:
    - stream recent-past events from the DB to a centralized event-bus
    - subscribe Elasticsearch as a data consumer 
    - preserve database transactions as an event-log
    - implement data-sourcing architecture 
- Advantages
    1. generic support for all event types - create, update & delete.
    2. efficient resource utilization due to the publisher-subscriber mechanism.
    3. transactions data is preserved inorder to meet future BI data analytics requirements.
    4. support for future embedding of various data consumers (e.g. mongoDB).
    5. cloud native microsearvices architecture.
    
##### system components:
- aws managed services:
    - amazon kinesis streams
    - amazon simple storage service (s3)
    - amazon athena 
- microservices:
    - mysql2kinesis job
    - kinesis2elastic cronjob
    - mysql2s3 cronjob
    - snapshot creator
    - generic athena client to perform log-retrieving queries
    - s32elastic job
   
##### Platform
The entire system will be hosted at aws cloud
services will be packaged as docker images and deployed to our aws eks cluster
 
##### monitoring tools
amazon cloudWatch service will be used to monitor kinesis and athena services.
the microservices will be monitored by kubernets-native monitoring tools (i.e. prometheus stack)

##### Development platform
services local build using docker-compose

##### costs estimation:
- kinesis stream: (200 records per minute, 50kb each, 4 consumers):
    Shard hours per month cost: 12.41$
    PUT Payload Units per month cost: 0.29$ 
    Extended data retention cost: 16.79$ (optional)
    **total monthly cost: 30$** [calculator](https://aws.amazon.com/kinesis/data-streams/pricing/)

- aws athena:
$5 per TB of data scanned

- aws s3:
    - standard storage class (event-log): 23$/TB
    - infrequent access class (snapshots): 12$/TB

- services:
 ???

##### Time estimation
- cloudformation for kinesis, s3 & athena: 2 days
- microservices: 10 weeks

##### microservices high-level overview:
- mysql2kinesis job
    this job will inifintly read events from the RDS mysql-binlog, and stream them to aws kinesis stream.
    will be written in python3 and use mysql-replication and aws boto3 libraries to perform the streaming.
- kinesis2elastic cronjob
- kinesis2s3 cronjob
    this job will run on a predifined schedule (e.g. nightly), and read all kinesis unreaded records to the event-log. 
- snapshot creator
    this job will run on a predifined schedule (e.g. once a week), perform a state snapshot, like a milestone, and store it at s3 infrequent-access bucket.
    will use mysql-client and aws sdk to read from db and write a snapshot to s3
- athena-inquirer
    only accessible across the k8s cluster, will listen to api requests and query athena for logs and snapshots. 
- s32elastic job
    on any desired time this job will be able to ask the athena-inquirer for snapshots & log, and feed Elasticsearch with the recieved data.
    


