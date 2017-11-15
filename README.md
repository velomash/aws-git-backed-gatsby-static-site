# Simple AWS Hosting for Gatsby based Static Sites
### complete with continuous delivery from Github

![diagram](https://raw.githubusercontent.com/velomash/aws-git-backed-gatsby-static-site/master/architecture.png "Architecture dagram: Git-backed static website powerd by AWS")

<!--[![AWS Launcher Button](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=gatsby_static_site&templateURL=https://raw.githubusercontent.com/velomash/aws-git-backed-gatsby-static-site/master/cloudformation.yaml)-->

## Overview

This project makes it simple to host sites made with the
[Gatsby static site generator](https://www.gatsbyjs.org/) using
Amazon Web Services. 

This AWS architecture watches a github repository. Any time you
push a new commit CodePipeline pulls the github source code,
generates static files using CodeBuild with the latest version of
Gatsby, then uploads the static files to an S3 bucket. When you
first launch a stack using this template it will setup an SSL
certificate, DNS routing, and cloudfront distributions so that
you can serve your static files safely, securely and mega fast.

Benefits of this architecture include:

 - Trivial to launch - Can use aws-cli or AWS console

 - Maintenance-free - Amazon is responsible for managing all the
   services used.

 - Negligible cost at substantial traffic volume - Starts off as low
   as $0.51 per month if running alone in a new AWS account. (Route 53
   has no free tier.) Your cost may vary over time and if other
   resources are running in your AWS account.

 - Scales forever - No action is needed to support more web site
   traffic, though the costs for network traffic and DNS lookups will
   start to add up to more than a penny per month.

## Installation

Installing and using the AWS architecture is incredibly easy. Before
you begin make sure you have a github repository that contains a
Gatsby project. Then follow these instructions:

  1. Clone this repo.

  2. Make a copy of the example-config.env called config.env and fill
  each item in the config with your own information. You'll need a github
  OAuth token. If you don't have one, make one by [following the github docs](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/).

  3. Run the create command: `npm run create`

  4. When the stack starts up, two email messages will be sent to the
  address associated with your domain's registration and one will be
  sent to your AWS account address. Open and approve each email. The
  CloudFormation stack will be stuck until the ACM certificates are
  approved. The CloudFront distributions are created afterwards and can
  take over 30 minutes to complete.

  5. Open the Route 53 dashboard. Open the newly created hosted zone which
  will be named based on the domain you entered in the config. Assign the
  nameservers of your registered domain to those listed in the NS record
  of your hosted zone.

  6. Enjoy fast, secure, and cheap hosting!!
