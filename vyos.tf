


# # Define instances
# resource "aws_instance" "vyos" {
#   count = 3
#   ami = var.ami
#   instance_type = var.instance_type
#   key_name = "my-key-pair"
#   subnet_id = module.vpc.public_subnets[0]
#   vpc_security_group_ids = [aws_security_group.vyos.id]
#   user_data = <<-EOF
#               #!/bin/bash
#               set -e
#               echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
#               sysctl -p /etc/sysctl.conf
#               EOF

#   tags = {
#     Name = "vyos-${count.index}"
#   }
# }


# resource "aws_instance" "vyos" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   subnet_id     = aws_subnet.default.id
#   vpc_security_group_ids = [
#     aws_security_group.vyos.id
#   ]
#   user_data = <<-EOF
#               #!/bin/bash
#               apt-get update
#               apt-get -y install curl
#               curl -L https://downloads.vyos.io/rolling/current/amd64/vyos-rolling-latest.iso -o vyos.iso
#               apt-get -y install genisoimage
#               genisoimage -quiet -o /opt/vyos-rolling.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R /mnt/vyos
#               apt-get -y install qemu-utils
#               qemu-img convert -O raw /opt/vyos-rolling.iso /dev/xvdf
#               set -e
#               echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
#               sysctl -p /etc/sysctl.conf
#               EOF

#   tags = {
#     Name = "VyOS Router"
#   }
# }

user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get -y install curl
              curl -L https://downloads.vyos.io/rolling/current/amd64/vyos-rolling-latest.iso -o vyos.iso
              apt-get -y install genisoimage
              genisoimage -quiet -o /opt/vyos-rolling.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R /mnt/vyos
              apt-get -y install qemu-utils
              qemu-img convert -O raw /opt/vyos-rolling.iso /dev/xvdf
              echo 'set interfaces ethernet eth1 description "Internal Network"' >> /config/config.boot
              echo 'set interfaces ethernet eth1 address 192.168.1.1/24' >> /config/config.boot
              echo 'set interfaces ethernet eth2 description "External Network"' >> /config/config.boot
              echo 'set interfaces ethernet eth2 address dhcp' >> /config/config.boot
              EOF