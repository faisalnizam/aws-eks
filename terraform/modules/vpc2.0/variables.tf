variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
}

variable "region" {
  description = "(Optional) If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee."
}

variable "prefix" {

}

variable "env" {

}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
}

variable "public_subnets" {
  type        = map(list(string))
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
}

variable "private_subnets" {
  type        = map(list(string))
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
}

variable "loadbalancer_subnets" {
  type        = map(list(string))
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
}

variable "database_subnets" {
  type        = map(list(string))
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
}

variable "middleware_subnets" {
  type        = map(list(string))
  description = "Map from availability zone to the list of subnets correspoding to that AZ"
}

variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
}

variable "attach_nat_gateway_to_rt" {
  description = "Shoulkd be true if you want to attach the NAT Gateway to the private route table."
  type        = bool
}

variable "reuse_nat_ips" {
  description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
  type        = bool
}

variable "external_nat_ip_ids" {
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  type        = bool
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
}

variable "loadbalancer_subnet_tags" {
  description = "Additional tags for the loadbalance subnets"
  type        = map(string)
}

variable "database_subnet_tags" {
  description = "Additional tags for the database subnets"
  type        = map(string)
}

variable "middleware_subnet_tags" {
  description = "Additional tags for the middleware subnets"
  type        = map(string)
}

variable "database_subnet_group_tags" {
  description = "Additional tags for the database subnet group"
  type        = map(string)
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
}

variable "loadbalancer_route_table_tags" {
  description = "Additional tags for the loadbalancer route tables"
  type        = map(string)
}

variable "database_route_table_tags" {
  description = "Additional tags for the database route tables"
  type        = map(string)
}

variable "middleware_route_table_tags" {
  description = "Additional tags for the middleware route tables"
  type        = map(string)
}

variable "dhcp_options_tags" {
  description = "Additional tags for the DHCP option set (requires enable_dhcp_options set to true)"
  type        = map(string)
}

variable "nat_gateway_tags" {
  description = "Additional tags for the NAT gateways"
  type        = map(string)
}

variable "nat_eip_tags" {
  description = "Additional tags for the NAT EIP"
  type        = map(string)
}

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
}

variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable_dhcp_options set to true)"
  type        = list(string)
}

variable "dhcp_options_ntp_servers" {
  description = "Specify a list of NTP servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
}

variable "dhcp_options_netbios_name_servers" {
  description = "Specify a list of netbios servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
}

variable "dhcp_options_netbios_node_type" {
  description = "Specify netbios node_type for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
}

variable "policy_path" {
  description = "Path to policy folder with json files"
}

variable "vpc_flow_logs_policy_name" {
  description = "File name for JSON policy"
}

variable "default_vpc_id" {
  description = "The ID of the default VPC"
}

variable "custom_vpc_id" {
  description = "The ID of the custom default VPC"
  default     = ""
}

variable "default_vpc_def_rt_id" {
  description = "The ID of the default RT in the default VPC"
}

variable "vpc_cloudwatch_log_group_retention" {}

variable "subnet_ids" {
  description = "The Subnet IDs used for the TGW Attachment"
  type        = "list"
  default     = []
}

variable "tgw_id" {
  description = "The ID of the TGW"
  default     = {}
}

variable "vpc_id" {
  description = "The VPC ID which will be attached to the TGW"
  default     = {}
}

variable "route_table_ids" {
  description = "The Route Table IDs which will hold routes to the TGW"
  type        = "map"
  default     = {}
}

variable "destination_cidr_block_to_tgw" {
  description = "The Destination CIDR Block which will go to the TGW"
  type        = "list"
  default     = []
}

variable "attach_vpc_to_tgw" {
  description = "If we what to attached the VPC to TGW, then the value should be true"
  type        = bool
}

variable "transit_vpn_connection" {
  description = "Controls if VPN connection should be created"
  type        = bool
  default     = false
}

variable "vpn_type" {
  description = "The type of VPN/CGW. AWS supports only ipsec.1 at this time"
  default     = "ipsec.1"
}

variable "cgw_ip" {
  description = "The external IP address of the customer gateway"
  default     = ""
}

variable "vpn_static_routing" {
  description = "Whether the VPN connection uses static routes or BGP."
  type        = bool
  default     = false
}

variable "vpc_supernet" {
  description = "CIDR of the VPC supernet"
  default     = ""
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number for the Amazon VGW"
  default     = "64513"
}

variable "bgp_asn" {
  description = "The Autonomous System Number for the customer's gateway"
  default     = "65000"
}

variable "create_vgw" {
  description = "Whether to create a VGW."
  type        = bool
  default     = true
}

variable "vgw_id" {
  description = "The ID of the VGW (in case it's being imported)."
  default     = ""
}
