# update-route53

This project implements a container in which an ansible playbook runs. The playbook uses ipify.org to determine the external Internet IP address of a connection, then compares the result to a record in AWS Route53 DNS service. If the records do not match, the playbook will update Route53 with the new value, and wait for it to propigate.

## prerequisites

Assuming that

+ You have servers running on a home or small business network, connected to the Internet via some ISP service (cable modem, Fiber optic terminus, etc.)
+ The service you are using allows incoming traffic, and provides you with an IPV4 address, and api.ipify.org correctly identifies that address (when run from inside your local network.)
+ You have something acting as a firewall and/or router, that directs incoming TCP traffic to those servers.
+ You are using AWS Route 53, have a DNS zone established, and have a DNS type "A" record that you want to point to the IPV4 address provided by your ISP.
+ You have some internal service that can run this container periodically. 

## requirements

+ You will need to set up an IAM user and generate an access key and secret for that user. The user will need permissions to view and update/create records in the AWS Route53 hosted zone for your DNS domain.

## configuration

See `env.txt.example` for a list of environment variables required at execution time.