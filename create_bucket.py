import boto3

s3 = boto3.resource('s3')

s3.create_bucket(Bucket='eng114-sharmake-bucket', CreateBucketConfiguration={

    'LocationConstraint': 'eu-west-1'})

