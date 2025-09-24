+++
title = "Bring Your Own Cloud Bucket"
description = "Learn how to setup Highlighter to use your own Cloud  Bucket to store data."
date = 2024-03-12T08:00:00+00:00
updated = 2024-03-12T08:00:00+00:00
draft = false
weight = 100
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

## Overview

The Bring Your Own Cloud Bucket feature allows you to configure Highlighter to store and access your assessment data directly in your own AWS S3 bucket, rather than using Highlighter's default storage. This provides you with:

- **Full control** over your data location and storage policies
- **Cost transparency** - storage costs appear directly on your AWS bill
- **Security compliance** - data remains within your AWS environment
- **Access control** - manage bucket permissions according to your organization's policies

This guide will walk you through setting up the necessary AWS permissions and configuring the Cloud Credential in Highlighter.

## Prerequisites

Before starting, ensure you have:

- **AWS Account** with administrative access
- **Highlighter account** with administrator privileges
- **S3 bucket** already created for storing Highlighter data
- Access to create and manage **IAM roles** in your AWS account

## Step 1: Get Your External ID

1. Log into your Highlighter account
2. At the bottom left where your profile photo is, click on the chevron and navigate to **Cloud Credentials**
3. Click **Add New Cloud Credential**
4. At this stage just copy the External ID, which you will need later on in setting up the Trust Policy.

## Step 2: Create a S3 Permissions Policy

This next step creates a permissions policy that grants Highlighter the necessary S3 access:

1. In your AWS account, Navigate to **IAM** → **Policies** → **Create policy**
2. Click **Policy Editor**, and then switch to the **JSON** editor
4. Replace the default policy with the following (replace `CUSTOMER_BUCKET_NAME` with your actual bucket name):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:ListBucketVersions",
        "s3:ListMultipartUploadParts"
      ],
      "Resource": "arn:aws:s3:::CUSTOMER_BUCKET_NAME"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:DeleteObject",
        "s3:DeleteObjectTagging",
        "s3:DeleteObjectVersion",
        "s3:DeleteObjectVersionTagging",
        "s3:GetObject",
        "s3:GetObjectAttributes",
        "s3:GetObjectLegalHold",
        "s3:GetObjectRetention",
        "s3:GetObjectTagging",
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAttributes",
        "s3:GetObjectVersionTagging",
        "s3:ListBucketMultipartUploads",
        "s3:ListMultipartUploadParts",
        "s3:PutObject",
        "s3:PutObjectLegalHold",
        "s3:PutObjectRetention",
        "s3:PutObjectTagging",
        "s3:PutObjectVersionTagging",
        "s3:RestoreObject"
      ],
      "Resource": "arn:aws:s3:::CUSTOMER_BUCKET_NAME/*"
    }
  ]
}
```

5. Give the policy a descriptive name like `HighlighterS3BucketAccess`
6. Click **Create policy**

## Step 3: Create IAM Role

Now that we have a permissions policy, let's create a new IAM role in your AWS account that Highlighter can assume to access your S3 bucket.

### In the AWS Console:

1. Navigate to **IAM** → **Roles** → **Create role**
2. Select **AWS account** as the trusted entity type
3. Choose **Another AWS account**
4. Enter the Highlighter AWS Account ID: `195892427074`
5. Check **Require external ID** 
7. Click **Next**
8. Adding permission policy from Step 2, eg., `HighlighterS3BucketAccess`
8. Click **Next**
9. Configure the role details:
   - **Role name**: `HighlighterBucketAccessRole`
   - **Description**: `Role for Highlighter to access data in my AWS S3 buckets`
10. Click **Create role**

### Configure the Trust Policy

After creating the role, you need to update its trust policy:

1. Find your newly created role and click on it
2. Go to the **Trust relationships** tab
3. Click **Edit trust policy**
4. Replace the existing policy with the following (replace `YOUR_EXTERNAL_ID` with the External ID from Step 1):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::195892427074:user/highlighter.data.broker.role"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "YOUR_EXTERNAL_ID"
        }
      }
    }
  ]
}
```

5. Click **Update policy**

## Step 4: Configure Cloud Credential in Highlighter

Once you have completed the AWS setup of the role for Highlighter to assume:

1. Navigate back to your New Cloud Credential page in Highlighter
2. Fill in the required information:
   - **Name**: A descriptive name for this credential (e.g., "My Company S3 Bucket")
   - **Provider**: Select **AWS S3**
   - **Role ARN**: The ARN of your IAM role (e.g., `arn:aws:iam::123456789012:role/HighlighterBucketAccessRole`)
   - **Bucket Name**: Your S3 bucket name
   - **Region**: Your S3 bucket's AWS region
3. Click **Test Connection** to verify the setup
4. If successful, click **Save**

## Step 5: CORS setup

1. Back in the AWS console go to your bucket and click the Permissions tab. Scroll down to the Cross-origin resource sharing (CORS) section and click the Edit button.
2. Paste in the following, replacing `YOUR_HIGHLIGHTER_ACCOUNT` with the URL of your Highlighter account, for example `my-company.highlighter.ai`.

```json
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET",
            "POST",
            "HEAD",
            "DELETE",
            "PUT"
        ],
        "AllowedOrigins": [
            "https://YOUR_HIGHLIGHTER_ACCOUNT"
        ],
        "ExposeHeaders": [],
        "MaxAgeSeconds": 3000
    }
]
```

3. Click the Save changes button

## Step 6: Verification

After configuration, verify that the setup is working:

1. In Highlighter, try uploading a small test file or creating a new assessment workflow
2. Check your S3 bucket to confirm that data is being stored correctly
3. Monitor CloudTrail logs (if enabled) to see Highlighter's assume role activities

## Troubleshooting

### Common Issues

**"Access Denied" errors:**
- Verify the External ID matches exactly
- Check that the IAM role ARN is correct
- Ensure the S3 permissions policy includes all required actions
- Confirm the bucket name is spelled correctly

**"Unable to assume role" errors:**
- Check that the trust policy includes the correct Highlighter principal
- Verify the External ID condition is properly formatted
- Ensure the role exists and is active

**Connection test fails:**
- Verify your S3 bucket exists and is in the specified region
- Check that the IAM role has been properly configured
- Contact Silverpond support to verify the External ID

### Getting Help

If you encounter issues:
1. Check the AWS IAM and S3 console for any error messages
2. Verify all ARNs and IDs are correctly copied
3. Contact Silverpond support with your role ARN and any error messages

## Security Considerations

- **Principle of Least Privilege**: The provided S3 permissions are the minimum required for Highlighter to function
- **External ID**: Never share your External ID publicly - it's a security credential
- **Role Access**: Regularly review who has access to modify your IAM role
- **Bucket Policies**: Consider additional bucket-level policies for enhanced security
- **Monitoring**: Enable CloudTrail logging to monitor access to your resources
