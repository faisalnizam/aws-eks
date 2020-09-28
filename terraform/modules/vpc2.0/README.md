<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cidr | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | string | n/a | yes |
| create\_database\_subnet\_group | Controls if database subnet group should be created | bool | n/a | yes |
| create\_vpc | Controls if VPC should be created (it affects almost all resources) | bool | n/a | yes |
| database\_route\_table\_tags | Additional tags for the private route tables | map(string) | n/a | yes |
| database\_subnet\_group\_tags | Additional tags for the database subnet group | map(string) | n/a | yes |
| database\_subnet\_tags | Additional tags for the private subnets | map(string) | n/a | yes |
| database\_subnets | Map from availability zone to the list of subnets correspoding to that AZ | map(list(string)) | n/a | yes |
| dhcp\_options\_domain\_name | Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true) | string | n/a | yes |
| dhcp\_options\_domain\_name\_servers | Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable_dhcp_options set to true) | list(string) | n/a | yes |
| dhcp\_options\_netbios\_name\_servers | Specify a list of netbios servers for DHCP options set (requires enable_dhcp_options set to true) | list(string) | n/a | yes |
| dhcp\_options\_netbios\_node\_type | Specify netbios node_type for DHCP options set (requires enable_dhcp_options set to true) | string | n/a | yes |
| dhcp\_options\_ntp\_servers | Specify a list of NTP servers for DHCP options set (requires enable_dhcp_options set to true) | list(string) | n/a | yes |
| dhcp\_options\_tags | Additional tags for the DHCP option set (requires enable_dhcp_options set to true) | map(string) | n/a | yes |
| enable\_dhcp\_options | Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type | bool | n/a | yes |
| enable\_dns\_hostnames | Should be true to enable DNS hostnames in the VPC | bool | n/a | yes |
| enable\_dns\_support | Should be true to enable DNS support in the VPC | bool | n/a | yes |
| enable\_nat\_gateway | Should be true if you want to provision NAT Gateways for each of your private networks | bool | n/a | yes |
| env |  | string | n/a | yes |
| external\_nat\_ip\_ids | List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips) | list(string) | n/a | yes |
| igw\_tags | Additional tags for the internet gateway | map(string) | n/a | yes |
| instance\_tenancy | A tenancy option for instances launched into the VPC | string | n/a | yes |
| map\_public\_ip\_on\_launch | Should be false if you do not want to auto-assign public IP on launch | bool | n/a | yes |
| nat\_eip\_tags | Additional tags for the NAT EIP | map(string) | n/a | yes |
| nat\_gateway\_tags | Additional tags for the NAT gateways | map(string) | n/a | yes |
| one\_nat\_gateway\_per\_az | Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`. | bool | n/a | yes |
| policy\_path | Path to policy folder with json files | string | n/a | yes |
| prefix |  | string | n/a | yes |
| private\_route\_table\_tags | Additional tags for the private route tables | map(string) | n/a | yes |
| private\_subnet\_tags | Additional tags for the private subnets | map(string) | n/a | yes |
| private\_subnets | Map from availability zone to the list of subnets correspoding to that AZ | map(list(string)) | n/a | yes |
| public\_route\_table\_tags | Additional tags for the public route tables | map(string) | n/a | yes |
| public\_subnet\_tags | Additional tags for the public subnets | map(string) | n/a | yes |
| public\_subnets | Map from availability zone to the list of subnets correspoding to that AZ | map(list(string)) | n/a | yes |
| region | (Optional) If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee. | string | n/a | yes |
| reuse\_nat\_ips | Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable | bool | n/a | yes |
| tags | A map of tags to add to all resources | map(string) | n/a | yes |
| vpc\_flow\_logs\_policy\_name | File name for JSON policy | string | n/a | yes |
| vpc\_tags | Additional tags for the VPC | map(string) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_subnet\_ids | List of IDs of Database subnets |
| database\_subnets | MAP of IDs of database subnets and coresponding cidr |
| db\_group\_name | DB subnet goup name |
| default\_network\_acl\_id | The ID of the default network ACL |
| default\_security\_group\_id | The ID of the security group created by default on VPC creation |
| igw\_id | The ID of the Internet Gateway |
| nat\_ids | List of allocation ID of Elastic IPs created for AWS NAT Gateway |
| nat\_public\_ips | List of public Elastic IPs created for AWS NAT Gateway |
| natgw\_ids | List of NAT Gateway IDs |
| private\_route\_table\_id | ID of private route table |
| private\_subnet\_ids | List of IDs of private subnets |
| private\_subnets | MAP of IDs of public subnets and coresponding cidr |
| public\_route\_table\_id | List of IDs of public route tables |
| public\_subnet\_arns | List of ARNs of public subnets |
| public\_subnet\_ids | List of IDs of public subnets |
| public\_subnets\_cidr\_blocks | List of cidr_blocks of public subnets |
| vpc\_arn | The ARN of the VPC |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_enable\_dns\_hostnames | Whether or not the VPC has DNS hostname support |
| vpc\_enable\_dns\_support | Whether or not the VPC has DNS support |
| vpc\_id | The ID of the VPC |
| vpc\_instance\_tenancy | Tenancy of instances spin up within VPC |
| vpc\_main\_route\_table\_id | The ID of the main route table associated with this VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->