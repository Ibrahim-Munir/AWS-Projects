import boto3
import os 
#Put your access key ID and secret access key ID in their respective place.
access_key_id = 'YOUR_ACCESS_KEY_ID'
secret_access_key = 'YOUR_SECRET_ACCESS_KEY_ID'

s3 = boto3.client('s3', aws_access_key_id=access_key_id, aws_secret_access_key=secret_access_key)

#Put the name of the bucket and the path to file in their respective place.
def upload_file(bucket_name, file_name):
    s3 = boto3.client('s3')
    s3.upload_file(file_name, bucket_name, file_name)
bucket_name = 'NAME-OF-BUCKET'
file_path = 'PATH-TO-FILE'
upload_file(bucket_name, file_path)

#Put the name of the bucket and the path to file in their respective place.
def download_file(bucket_name, file_name, output_name):
    s3 = boto3.client('s3')
    s3.download_file(bucket_name, file_name, output_name)
bucket_name = 'NAME-OF-BUCKET'
file_path = 'PATH-TO-FILE'
download_file(bucket_name, file_path)

#Put the name of the bucket and the path to file in their respective place.
def delete_file(bucket_name, file_name):
    s3 = boto3.client('s3')
    s3.delete_object(Bucket=bucket_name, Key=file_name)
bucket_name = 'NAME-OF-BUCKET'
file_path = 'PATH-TO-FILE'
delete_file(bucket_name, file_path)
