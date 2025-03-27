# Scheduled ECS Microservice

Deploys a microservice to ECS on a scheduled basis using AWS EventBridge and CodePipeline.

## Stack Overview

- ECS Fargate Task
- ECR Repository
- CloudWatch Logs
- CodeBuild & CodePipeline
- EventBridge Rule

## Deployment

```
aws cloudformation deploy \
  --template-file ECS-microservice-scheduled.yml \
  --stack-name scheduled-task \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    VpcId=vpc-xxxx \
    SubnetId=subnet-xxxx \
    MicroserviceName=demo \
    Environment=test \
    GitHubConnectionArn=arn:aws:codestar-connections:... \
    Reponame=my-org/my-repo \
    Branch=main \
    BucketNameForArtifacts=my-artifact-bucket
```
