Today you will be hosting a static website on AWS S3. This is an excellent project for beginners.
```
What you will need:
1. An AWS account
2. Website files

Services Used:
- S3
```

STEP 1: Create a S3 bucket:
Sign in to your AWS Management Console and navigate to the S3 service. Click on the "Create bucket" button to create a new bucket. Give it a name that matches your website's domain name and select a region closest to your users for better performance.


STEP 2: Configure website hosting for your bucket:
 Once your bucket is created, select it from the list and click on the "Properties" tab. Click on "Static website hosting" and select "Use this bucket to host a website". Enter the name of your index document (e.g. "index.html") and error document (e.g. "error.html") and click "Save".
 
 
STEP 3: Upload your website files:
Upload your website files to the S3 bucket using the console, AWS CLI, or any S3-compatible tool. Make sure that your index document and error document are included in the root directory of the bucket.


STEP 4: Set permissions for the bucket:
By default, all objects in your bucket are private. To allow public access to your website, you need to set permissions for your bucket. Select your bucket from the list and click on the "Permissions" tab. Click on "Bucket Policy" and paste the following policy, replacing "your-bucket-name" with the actual name of your bucket:
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadAccess",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::your-bucket-name/*"
            ]
        }
    ]
}
```

STEP 5: Enable the website endpoint
Finally, navigate to the "Static website hosting" tab and copy the website endpoint URL provided. You can use this URL to access your website.


CONGRATULATIONS! Your static website is now hosted on S3 and accessible to the public. Hopefully, this the first of many AWS projects to come. Note that S3 charges are based on the amount of data stored in the bucket, as well as any data transferred to and from the bucket. You can check the pricing details on the AWS website.




