import boto3

s3 = boto3.client('s3')


s3.download_file(
Filename = 'test2.txt',
Bucket = 'eng114-sharmake-bucket',
Key = 'test1.txt'
)

