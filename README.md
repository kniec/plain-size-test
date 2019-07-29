# plain-size-test
Play around with layer and image size

## ECR
To create an image and push it to ECR one needs to create a repository first.

```
$ aws ecr create-repository --repository-name kniec/plain-size-test --region eu-west-1
{
    "repository": {
        "registryId": "xxxxxxx",
        "repositoryName": "kniec/plain-size-test",
        "repositoryArn": "arn:aws:ecr:eu-west-1:xxxxxxx:repository/kniec/plain-size-test",
        "createdAt": 1564382782.0,
        "repositoryUri": "xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test"
    }
}
```

## Build
Export the returned URI base so that the image can be build.

```
$ export OCI_REG=xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com
$ ./build.sh
$ unset OCI_REG
```

### Inspect

As the files are sourced from `/dev/zero` they are super-easy to compress, thus they end up using only a couple of MB.

```
docker image ls|awk '/plain-size-test/'
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    10                           4d2774918544        53 seconds ago       11.3GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    9                            447d2d04d4a3        About a minute ago   10.2GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    8                            8b76081a06f0        About a minute ago   9.22GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    7                            6e6909da5cae        2 minutes ago        8.2GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    6                            3d31cf9cb00a        2 minutes ago        7.17GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    5                            567373a69d91        3 minutes ago        6.15GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    4                            385df437d6c9        3 minutes ago        5.13GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    3                            1b718b2f68fc        4 minutes ago        4.1GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    2                            417496290706        10 minutes ago       3.08GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    1                            67bbc9198bef        12 minutes ago       2.05GB
xxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/kniec/plain-size-test    0                            3cc61bd0ce65        16 minutes ago       1.03GB
```