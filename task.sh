
# !/bin/bash
Python  ec2launch.py
knife bootstrap  10.126.34.0 --sudo  -x  ec2-user  -i /root/Chefkey.pem  -N "node1"  -r                                 "recipe[Demobook]"
