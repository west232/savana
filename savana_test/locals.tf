
locals {
  ######################################## VPC
  vpcs = {
    savana_vpc = {
      cidr_block                           = "10.65.2.0/24"
      enable_dns_support                   = true
      enable_network_address_usage_metrics = true
      enable_dns_hostnames                 = true
      tags = {
        ENV  = "dev"
        Name = "savana_vpc"
      }
    }
  }
  ######################################## subnets
  subnets = {
    #public egress subnet 1  
    sub-pub = {
      vpc_id                                         = module.vpcs.vpc_id[0]
      cidr_block                                     = "10.65.2.0/28"
      availability_zone                              = "us-east-1a"
      map_public_ip_on_launch                        = true
      enable_resource_name_dns_aaaa_record_on_launch = false
      enable_resource_name_dns_a_record_on_launch    = false
      tags = {
        Name = "pub_savana_01"
        ENV  = "dev"
      }
    }

    sub-priv = {
      vpc_id                                         = module.vpcs.vpc_id[0]
      cidr_block                                     = "10.65.2.16/28"
      availability_zone                              = "us-east-1b"
      map_public_ip_on_launch                        = false //false if it's a private subnet
      enable_resource_name_dns_aaaa_record_on_launch = false
      enable_resource_name_dns_a_record_on_launch    = false
      tags = {
        Name = "priv_savana_01"
        ENV  = "dev"
      }
    }
  }
  ############################################ security groups
  security_groups = {
    seg_pub = {
      name                   = "seg_savana"
      vpc_id                 = module.vpcs.vpc_id[0]
      description            = "for test purpose1"
      revoke_rules_on_delete = "true"
      ingress = [
        {
          "description" = "For HTTP"
          "from_port"   = "80"
          "to_port"     = "80"
          "protocol"    = "tcp"
          "cidr_blocks" = ["0.0.0.0/0"]
        },
        {
          "description" = "For SSH"
          "from_port"   = "22"
          "to_port"     = "22"
          "protocol"    = "tcp"
          "cidr_blocks" = ["0.0.0.0/0"]
        },
        {
          "description" = "For efs"
          "from_port"   = "2049"
          "to_port"     = "2049"
          "protocol"    = "tcp"
          "cidr_blocks" = ["0.0.0.0/0"]
        },
        {
          "description" = "For efs"
          "from_port"   = "442"
          "to_port"     = "443"
          "protocol"    = "tcp"
          "cidr_blocks" = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          "from_port"   = "0"
          "to_port"     = "0"
          "protocol"    = "-1"
          "cidr_blocks" = ["0.0.0.0/0"]
        }
      ]
      tags = {
        Name = "seg_savana"
        ENV  = "dev"
      }
    }
  }
  ########################################### internet gateway
  internet_gw = {
    igw_prov = {
      vpc_id = module.vpcs.vpc_id[0]
      tags = {
        Name = "igw_savana"
        env  = "dev"
      }
    }
  }

  #################################################### nat gatway
  nat-gateway = {
    ngw-dev01 = {
      subnet_id     = data.aws_subnet.pub_savana.id
      allocation_id = module.eip.eip_id[0]
      tags = {
        Name = "ngw_savana"
        ENV  = "dev"
      }
    }
  }
  ################################################## elastic ip
  eip = {
    eip-01 = {
      domain = "vpc"
      tags = {
        Name = "eip_savana"
        env  = "dev"
      }
    }
  }
}