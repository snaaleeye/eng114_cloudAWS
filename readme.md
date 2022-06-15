### What is Cloud Computing

Cloud computing is when you use a network of remote servers hosted on the internet to store, manage, and process date, rather than a local server or a personal computer. 

# Benefits
- Security 
- Reliability
- Scalability
- Collaboration
- Efficiency and cost effectiveness
- Flexibility
- Loss prevention
- Disaster recovery
- Automatic Software updates
- Competitive Edge
- Sustainability 

https://www.salesforce.com/products/platform/best-practices/benefits-of-cloud-computing/

# How does it fit into DevOps?

3 million hours 
Security - information security team Biometric 
Air conditioning - heat for optimisation
Multiple ways of destroying

Pay as you go 
Built on premises 
Helps us release software faster
Able to adapt quickly
Not beneficial for small scale/offices/labs

The Monolith
- Simple but has limitations and complexity 
- Heavy apps can slow down the start up time
- Each update results into redeploying the full stack app
- Challenging to scale up on demand
- Fruitful for simple and lightweight apps

<img width="99" alt="Screenshot 2022-06-08 at 14 18 20" src="https://user-images.githubusercontent.com/105854053/172626664-155221fa-f7f1-46cb-8c31-e6a109b1aa86.png">

- AWS Service

- EC2 - security group/s

- Data migration to cloud 

### What is Amazon Web Services (AWS)

AWS (Amazon Web Services) is a comprehensive, evolving cloud computing platform provided by Amazon that includes a mixture of infrastructure as a service (IaaS), platform as a service (PaaS) and packaged software as a service (SaaS) offerings.

Availability zones are important in case one data centre goes down to avoid having a single point of failure. 
Where there is a issue with zone, you would be diverted 

- Most functionality 
- Largest community of customers and partners 
- Most secure
- Fastest pace of innovation 
- Most proven operational expertise

AWS has the most extensive global cloud infrastructure. No other cloud provider offers as many Regions with multiple Availability Zones connected by low latency, high throughput, and highly redundant networking. AWS has 84 Availability Zones within 26 geographic regions around the world, and has announced plans for 24 more Availability Zones and 8 more AWS Regions in Australia, Canada, India, Israel, New Zealand, Spain, Switzerland, and United Arab Emirates (UAE). The AWS Region and Availability Zone model has been recognized by Gartner as the recommended approach for running enterprise applications that require high availability.

<img width="810" alt="Screenshot 2022-06-08 at 14 06 38" src="https://user-images.githubusercontent.com/105854053/172626761-20fdcac1-1800-4368-9140-8caf4a40f02a.png">


https://aws.amazon.com/what-is-aws/

### AWS best practices - naming convention

- Maximum number of tags per resource – 10
- Maximum key length – 127 Unicode characters 
- Maximum value length – 255 Unicode characters
- Tag keys and values are case sensitive 
- Tag keys must be unique per resource  
- Do not use the “aws:” prefix in your tag name or values because it is reserved for AWS use


security group rules: allow port
allow port 22 from your ip only. 
globally ssh port 22
allow port 80 for nginx (this is a default port for browser)
allow port 3000 for access. 


mongoDB Task

- Create new ubuntu 18.04 instance/server
- create a security group for our db
- Allow our localhost to ssh in means port 22
- Allow default port access of mongodb 27017
- db must not have public access 
- mongodb configuration - the same script should work
- make the changes to mongod.conf file to allow app ip to connect to 27017
- restart and enable mongodb

# Two-Tier Architecture
The client is on the first tier and the database server and web application server reside on the same seerver machine on the second tier. 

The second tier serves the data and executes the business logic for the web application

The second tier is responsible for providing the availability, scalability, and performance characteristics for the organisation's web environment 

### How to set up app and mongoDB on AWS

### Create instance on AWS for app

1. Instance details
- use default network 
- use subnet default eu-west 1a
- Auto-assign Public IP - Enable (if you are in production it has to be private)

2. Tags
Follow AWS naming convention e.g. Name eng114_sharmake_app

3. Configure Security Group
Create new or use existing e.g. eng114_sharmake_db_sg (name + description)
- allow port 22 from your ip only - globally ssh 
- allow port 80 for nginx (this is a default port for browser)
- allow port 3000 for access 

4. Setting up instance for DB is the same but make ip for security group 27017 app ip/32

### Connect local to AWS
Inside local .ssh folder do the following commands:
1. chmod 400 name.pem
2. ssh -i ".pem" ubuntu@ec2... compute.amazonaws.com

To copy file or folder do the following. 
- For directory add -r after .pem
 scp -i name.pem "file you want to move without quotes" ubuntu@ip... compute.amazonaws.com: if you want to send file to a specific area add it here, if not leave blank. 

 scp or rsync - common commands used to migrate

 Moving directories takes a very long time. 

### Once inside the app secure shell (.ssh) run the following commands.

`sudo apt-get update -y`
`sudo apt-get upgrade -y`

`sudo apt-get install nginx -y`

`sudo systemctl start nginx`
`sudo systemctl enable nginx`
`sudo systemctl status nginx`

`curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -`
`sudo apt-get install -y nodejs`
`sudo apt-get install npm`
`sudo npm install pm2 -g`

`sudo apt-get install python-software-properties -y`

`sudo nano cp default /etc/nginx/sites-available/` # port 3000 details
`sudo nginx -t`
`sudo systemctl restart nginx`
`sudo systemctl enable nginx`

`sudo echo "export DB_HOST=mongodb://172.31.20.139:27017/posts" >> ~/.bashrc`
`source ~/.bashrc`

cd app/app/
`sudo npm install -y`
`sudo npm start -d`

- At this point the nginx page and app should work. 

### Move into the db secure shell (ssh) and run the following commands

`sudo apt-get update -y` #checks the internet

`sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927`

`echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list`

`sudo apt-get update -y`
`sudo apt-get upgrade -y`

`sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20`

`sudo nano /etc/mongod.conf` - change this to 27017 and 0.0.0.0 to allow all or to make it private enter app ip

`sudo systemctl restart mongod`
`sudo systemctl enable mongod`
`sudo systemctl status mongod`

### Move back into the app ssh and repeat these steps inside app machine

cd app/app/
`sudo npm start -d`

### If the text does not appear try this inside app ssh
cd app/app/
`node seeds/seed.js`
`sudo npm start -d`

### To run after leaving ssh run 
`sudo npm start -d nohup node server.js > /dev/null 2>&1 &` # to run in the background 


Tips:
Make sure rules are correct in instance
Make sure DB_HOST name is correct
Check mongod.conf is correct 
Check correct versions are running. 
Check nginx status
Check mongod status
Check default port 3000 file is correct
Check all ips are correct

[li (3).pdf](https://github.com/snaaleeye/eng114_cloudAWS/files/8899874/li.3.pdf)


What are Amazon Machine Image - AMI
- AMI allows you to store a snapshot of your instance. 
some sort of cost is still being charged
save money not lose data 
Create a snapshot 

How to create AMI?
1. Tick the instance you want to copy
2. Click actions - images and templates - create image
3. Enter image name and image description e.g. eng114_sharmake_db_ami

How to use AMI?
1. Go AMI and find the AMI you created
2. Tick the AMI you want to use
3. Launch instance from AMI
4. Connecting is the same as for a regular instance
5. Make sure to update security group + environment variable

When using AMI - ensure when connecting to instance to change root to ubuntu e.g. ssh -i ".pem" root@ec2ip.eu-west-1.compute.amazonaws.com should be ssh -i ".pem" ubuntu@ec2ip.eu-west-1.compute.amazonaws.com 

![ami_lifecycle](https://user-images.githubusercontent.com/105854053/173582529-342b74c3-0508-4428-9f05-588bfdae295f.png)


### Elastic IP
Biodomain example.com and link that IP to that domain so that the end user access the example.com regardless of the ip changes. This is the solution along with domain. 

We are not using it due to security groups as that cements and solidifies our knowledge. Elastic IP cost money. Ireland only allows us to only use 5 IP so not enough bandwidth. We have exhausted. There is a website that can collect your IP automatically in a script and inject that into the virtual environment. Also forward DNS. Cost involved. AWS is not free. Github we can host our own website as long as the website is static and not dynamic. S3 bucket to host static websites. Static websites are good for your own where you don’t need user input as there is no business logic involved. 

Sometimes the code that has been developed is not good. Do not hesitate to let them know. Never try to fix their code. Apply two-min rule, if it is easy to fix then do it, if not send back to development team. You will be blamed if you change too much. Send back to developers with screenshot. For example, node seeds/seed.js code not in documentation but we found it. 

Someone creates subnet
Someone builds the infrastructure to use
You will not do everything inside a team. 

You can make an executive decision to override certain commands in order to migrate and edit the development team's if block. 

### Automating the process of setting up/configuring a product/app/db/web-app

- Bootstrap (aka userdata) the configuration of the product 
- #!/bin/bash
- add script
- This is done on step 3 in AWS configuration at the bottom

#!/bin/bash

var=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo $var

hostname -f

### Amazon S3
S3 is a simple storage service
Benefits:
1. s3 you can put any data. 
2. No data limit
3. Global service - highly available & scalable

Storage classes:
1. Standard class
The agreement between user and s3 is that we should be able to access data 24/7 - data is actively available

2. Clacier class
- Data is only available on request - non-active class - data is available but you have to give notice. You pay less. 

CRUD - Create Reade Update Delete

Using AWSCLI - configuration file allows encryption

DR - Disaster Recovery 

Dependencies required:
- Python 3 or above
- AWSCLI
- pip3
- Update & upgrade
- AWS access & secret keys for data security
- AWSCLI Configuration accesskeys + scret keys - 
region - eu-west1
language - json 

`aws s3 ls` to list buckets

`aws --version`

`aws configure` to add our keys and config

`aws s3 mb s3://name --region name`

`aws s3 cp s3://name/ file.md`

`aws s3 rm s3://bucketname --recursive`

`aws s3 rb s://bucketname`

`aws s3 sync s3://bucketname/ test`


# EC2 Setup 

#!/bin/bash

`sudo apt update`

`sudo apt upgrade -y`

`sudo apt install python3.7 -y`

`sudo apt install python3-pip -y`

`sudo pip3 install awscli`

`alias python=python3.7`

`python -m pip install boto3`

`#aws configure`
`#access key`
`#secret key`
`#eu-west-1`
`#json`

# Create bucket

import boto3

s3 = boto3.resource('s3')

s3.create_bucket(Bucket='eng114-sharmake-bucket', CreateBucketConfiguration={

    'LocationConstraint': 'eu-west-1'})

# Upload File

import boto3

s3 = boto3.client('s3')

s3.upload_file(
Filename = 'test.txt',
Bucket = 'eng114-sharmake-bucket',
Key = 'test1.txt'
)

# Retrieve File 

import boto3
s3 = boto3.client('s3')

s3.download_file(
Filename = 'test2.txt',
Bucket = 'eng114-sharmake-bucket',
Key = 'test1.txt'
)

# List Buckets
import boto3
s3 = boto3.resource('s3')

for bucket in s3.buckets.all():
    print(bucket.name)

# Delete Buckets

import boto3

s3 = boto3.client("s3")

s3.delete_bucket(Bucket = 'eng114-sharmake-bucket')

# Delete Content

import boto3

s3 = boto3.resource('s3')

s3.Object('eng114-sharmake-bucket', 'tests.txt').delete()

# Monitoring & Alert Management

1. Cloudwatch to monitor AWS service 
2. SNS - Simple notification service
3. SQS - simple queue service - 

What should we monitor?
- Error logs
- budgeting 
- latency 
- security breaches
- system tests/health
- instance health
- CPU utilisation %

4 Golden Signals
- Latency (Rquest Service Time)
- Traffic (User demand)
- Errors (Rate of failed requests)
- Saturation (Overall capacity of the system

<img width="592" alt="Screenshot 2022-06-14 at 11 43 34" src="https://user-images.githubusercontent.com/105854053/173582674-c67c4d3d-8c34-42ef-a997-5412d2b5e645.png">


Manage cloud watch 

# How to create an EC2 alarm?
1. Go to instance - actions - monitor and troubleshoot - Manage CloudWatch alarms 
2. Go to Amazon SNS - create topic - Connect email via subscription 
3. Set all details inside alarm notification and parameters and then create alarm
4. Go to CloudWatch and check if alarm is configured correctly to the correct email. 


<img width="389" alt="Screenshot 2022-06-14 at 14 04 38" src="https://user-images.githubusercontent.com/105854053/173583970-052719f1-6ea8-48e3-b373-e31deb2ff32a.png">


# Autoscaling and load balancing

- Autoscaling automatically adjusts the amount of computational resources based on the resources based on the server load. 

- Load balancing distrubtes traffic between EC2 so that no one instance gets overwhelmed. 

Minumum size = 2
Maximum size = 3
Desired capacity = 2 

Plan - Automate highly available scalable app
- Launch template
- Type of LB - elastic load balancer, application load balancer, network load balancer. 
- ALB - Application Load Balancer: target group/listener group HTTP
- ALB - Attach required dependencies 
- Auto-scaling group - attach this to ALB

# Create launch template

1. Instances - Launch Templates
2. Create launch template - Name launch template using dash - instead of underscore as it can cause issues later 
3. Choose Ubuntu 18.04
4. Instance type - t2.micro
5. Key pair - eng114
6. Select security group for app
7. Configure storage - 8gb
8. Add tags name
9. Create launch template

# Create auto scaling

1. Auto scaling - auto scaling groups - create autoscaling group
2. Autoscaling name = eng114-sharmake-asg
3. Find launch template created - default 1
4. Availability zones eu-west-1a + 1b + 1c
5. Attach to a new load balancer - application load balancer
6. Listeners and routing - create target group
6. Internet-facing 
7. Health check grace period at least 300 seconds 
8. Desired Capacity - Minumum Capacity - Maximum Capacity 
9. Target tracking scaling policy - enter policy
10. Add notification 
11. Add tags
12. Review and create auto scaling group 

![autoscaling-group](https://user-images.githubusercontent.com/105854053/173633472-220617cb-cf25-41f4-8249-a3c2a5839684.png)


# Terminate autoscaling group
 
Autoscaling group - select your autoscaling group - delete 

# Create an alarm 

SNS - Simple Notification Service

1. Topics - Create Topic 
2. Standard - name
3. Create topic
4. Subscriptions - endpoint = email address


Instances - Actions - Monitor and Troubleshoot - Manage CloudWatch alarms 

Auto scaling - Monitoring - EC2 - View all CloudWatch Metrics 

1. Choose Alarms.

2. Choose Create alarm.

3. Choose Select metric - EC2 - By Auto-scaling

4. Threshold type - Static.

5. Choose in Alarm.

6. Choose SNS topic

Surface level SLA

Single point of failure -

Content delivery network

Global Edge Network - look for closest one to avoid latency 

<img width="895" alt="Screenshot 2022-06-15 at 09 48 55" src="https://user-images.githubusercontent.com/105854053/173785161-6fb416e1-1a2d-4424-b185-9ba75cfe4a6d.png">

Performance testing
- Load testing
- Spike testing
- Stress testing
- Performance testing 


# Soak testing 

involves testing a system with a typical production load, over a continuous availability period, to validate system behavior under production use. 

For example, in software testing, a system may behave exactly as expected when tested for one hour. However, when it is tested for three hours, problems such as memory leaks cause the system to fail or behave unexpectedly.

# AWS VPC

## What is a VPC?

Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined. 

This virtual network closely resembles a traditional network that you'd operate in your own data centre, with the benefits of using the scalable infrastructure of AWS.

https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html

## Why should we use VPC? - Benefits of VPC?

- Easy to use and setup

Can be setup through AWS management console. 

Subnets, IP ranges, route tables and security groups are automatically created. 

- Security 

Provides advanced security features

- Scalability and Reliability

## What is an internet gateway?

An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet. 

An internet gateway enables resources (like EC2 instances) in your public subnets to connect to the internet if the resource has a public IPv4 address or an IPv6 address. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public IPv4 address or IPv6 address. 

An internet gateway serves two purposes: to provide a target in your VPC route tables for internet-routable traffic, and to perform network address translation (NAT) for instances that have been assigned public IPv4 addresses.

https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html

## What is a Subnet?

A subnet is a range of IP addresses in your VPC. You can attach AWS resources, such as EC2 instances and RDS DB instances, to subnets. 

You can create subnets to group instances together according to your security and operational needs.

A VPC can have upto 200 subnets.

https://docs.aws.amazon.com/quicksight/latest/user/vpc-subnets.html

<img width="500" alt="Screenshot 2022-06-15 at 11 14 31" src="https://user-images.githubusercontent.com/105854053/173803727-9b49da0c-eae0-4351-9d9a-87b60cec4536.png">


## What is a CIDR (Classless Inter-Domain Routing) block?

CIDR block a method for allocating IP addresses and IP routing in the VPC. The IP can be IPv4 or IPv6 format.

When you create a VPC, you assign it an IPv4/IPv6 CIDR block (a range of private and public IPv4/ipv6 addresses), or both (dual-stack). Private IPv4/IPv6 addresses are not reachable over the internet while public addresses are. To connect to your instance over the internet, or to enable communication between your instances and other AWS services that have public endpoints, you can assign a public IPv4/IPv6 address to your instance.


![ELB-outside-VPC](https://user-images.githubusercontent.com/105854053/173804302-88074176-cdbd-4d3d-a739-52d88fa22367.png)




## How to create a CIDR block?

1. Open the Amazon VPC console 

2. Choose Your VPCs.

3. Choose Actions, Edit CIDRs.

4. Choose Add new IPv4 CIDR.

5. For IPv4 CIDR block, do one of the following:

a) Choose IPv4 CIDR manual input and enter an IPv4 CIDR block.

b) Choose IPAM-allocated IPv4 CIDR and select a CIDR from an IPv4 IPAM pool.

OR

To associate an IPv6 CIDR block with a VPC using the console

1. Open the Amazon VPC console

2. Choose Your VPCs.

3. Choose Actions, Edit CIDRs.

5. Choose Add new IPv6 CIDR.

6. The CIDR block options when you add a CIDR are the same as when you create a VPC. 

7. Choose Select CIDR.

8. Choose Close.


## What is a NACLs - use case of NACL

Networking and Cryptography library - high-speed software library for network communication, encryption, decryption, signatures, etc

A network access control list (NACL) is an optional layer of security for your VPC that acts as a firewall for controlling traffic in and out of one or more subnets. You might set up NACLs with rules similar to your security groups in order to add an additional layer of security to your VPC

NACL work on a subnet level - generic rules.
Security groups work on an instance level. 

Virtual Private Cloud (VPC) 
10.0.0.0/16 
10.0.1.0/24

## Step 1: Create a VPC in Ireland eu-west-1

<img width="1438" alt="Screenshot 2022-06-15 at 13 34 19" src="https://user-images.githubusercontent.com/105854053/173827881-be20598a-90f9-4371-ab31-e4dc694de18d.png">

<img width="1419" alt="Screenshot 2022-06-15 at 13 35 16" src="https://user-images.githubusercontent.com/105854053/173828056-5243d917-70df-4045-82e4-fce0147dfa33.png">

<img width="811" alt="Screenshot 2022-06-15 at 13 35 47" src="https://user-images.githubusercontent.com/105854053/173828161-7a1d47a6-8bfc-450e-bcfe-48b12f4221eb.png">

## Step 2: Create Internet Gateway
- Attach the internet gatewaywith your VPC

<img width="871" alt="Screenshot 2022-06-15 at 13 36 42" src="https://user-images.githubusercontent.com/105854053/173828375-69f90fd6-2d78-435d-886d-ec9a5db20413.png">

<img width="1130" alt="Screenshot 2022-06-15 at 13 38 24" src="https://user-images.githubusercontent.com/105854053/173828703-a4de74f8-da51-4c24-8be7-a3e32e97e5c5.png">

## Step 3: Create a subnet/s - associate subnet with your VPC
10.0.9.0/24

<img width="869" alt="Screenshot 2022-06-15 at 13 40 27" src="https://user-images.githubusercontent.com/105854053/173829115-7ca4846e-32c0-466f-86b4-0fab7ac1b7df.png">

4. Create a route table within your VPC
- edit route table to add rules to connect to Internet Gateway 0.0.0.0 ig
- edit subnet association
-
<img width="868" alt="Screenshot 2022-06-15 at 13 41 45" src="https://user-images.githubusercontent.com/105854053/173829435-5f08e8f6-d7de-4194-b98f-b550bb2da54d.png">

<img width="1383" alt="Screenshot 2022-06-15 at 13 43 24" src="https://user-images.githubusercontent.com/105854053/173829676-15031c6a-c8d6-4047-b257-26a0e1b224d9.png">

