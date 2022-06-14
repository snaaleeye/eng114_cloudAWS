import boto3

s3 = boto3.client('s3')

s3.upload_file(
Filename = 'test1.txt',
Bucket = 'eng114-sharmake-bucket',
Key = 'test1.txt'
)


