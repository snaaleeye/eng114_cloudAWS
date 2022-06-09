### What is Cloud Comuting

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

scp or rsync - common commands used to migrate 

scp command example:
scp -i .pem -r /Users/sharmakenaaleeye/eng114_cloudAWS/app ubuntu@ip

Create mongoDB 

- Create new ubuntu 18.04 instance/server
- create a security group for our db
- Allow our localhost to ssh in means port 22
- Allow default port access of mongodb 27017
- db must not have public access 
- mongodb configuration - the same script should work
- make the changes to mongod.conf file to allow app ip to connect to 27017
- restart and enable mongodb