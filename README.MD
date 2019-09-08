## Introduction
This is a repository to store the result of  my interview test at Shopee ID

## Tutorial
### Deploying the wordpress

#### Put password in Parameter Store
1. Login to AWS Console and open Parameter Store inside System Manager Dashboard 
2. Click 'Create Parameter'
3. In the next page fill in the name as 'wordpress_db_password' and fill the password that will be used by wordpress in 'Value'
4. 

#### Create Cloudformation Stack
1. Go to Cloud Formation Dashboard
2. Click 'Create Stack' button and Select 'Template is ready' Tab
3. For the template source, choose 'Upload Template File'
4. Select the Wordpress.yaml from this repository and click Next
5. Fill in all the detail, such as Subnet ID, VPC Id, Image ID, and etcd
6. If you don't have Database configured, fill blank for tab 'Database Host ' and 'ECS Cluster'. Later it will be configured by cloudformation
7. Click 'Next' continously until you found final page, then click 'Create Stack'

