## Introduction
This is a repository to store the result of  my interview test at Shopee ID

## Tutorial
### Deploying the wordpress

#### Put password in Parameter Store
1. Login to AWS Console and open Parameter Store inside System Manager Dashboard 
2. Click 'Create Parameter'
3. In the next page fill in the name as 'wordpress_db_password' and fill the password that will be used by wordpress in 'Value'

#### Update ECS ARN Format
If this is not enabled, there will be an error when adding tag in ECS Service. 
1. Go to ECS Dashboard and click at the 'Account Settings'
2. Tick the box in the 'My IAM or role account settings' for Resource Service
3. Then click 'Save' at the bottom of the page

#### Create Cloudformation Stack
1. Go to Cloud Formation Dashboard
2. Click 'Create Stack' button and Select 'Template is ready' Tab
3. For the template source, choose 'Upload Template File'
4. Select the Wordpress.yaml from this repository and click Next
5. Fill in all the detail, such as Subnet ID, VPC Id, Image ID, and etcd
6. If you don't have Database configured, fill blank for tab 'Database Host ' and 'ECS Cluster'. Later it will be configured by cloudformation
7. Click 'Next' continously until you found final page, then click 'Create Stack'


### Using Bash Script to Change the 
1. Execute the bash scripts like the following 
```
./blog-resize.sh ECS_CLUSTER_NAME ECS_SERVICE_NAME EXPECTED_CAPACITY
```

Example
```
./blog-resize.sh EcsCluster Wordpress 1
```
