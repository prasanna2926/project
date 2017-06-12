1.A Python script which uses boto AWS SDK to launch an ec2 instance (linux ami)Install python
•	First we have install to python in our Linux machine.
apt-get  install  python * -y 
•	Next  we have install to Pycharm in our Linux machine.

                sh -c 'echo "deb http://archive.getdeb.net/ubuntu yakkety-getdeb apps" >>                    /etc/apt/sources.list.d/getdeb.list'
               wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add –
               sudo apt-get  update
               sudo apt-get  install pycharm

•	Now we have install to Boto3 module in Linux machine.
              pip install boto3

•	To Create python file 
	vi  ec2launch.py

               import boto.ec2
               import sys

                # specify AWS keys
               auth = {"aws_access_key_id": "AKIAJ2XJCGFIO57ZVCSA", "aws_secret_access_key":                        "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"}
              ec2 = boto.ec2.connect_to_region("us-east-1", **auth)
              ec2.run_instances(
              'ami-80861296',
              key_name='devopskey',
              instance_type='t2.micro',
              security_groups=['launch-wizard-1']
              )
      
 2. A Chef cookbook (with associated files) that can install Java and Tomcat server on this instance.
•	Create a cookbook by using below command.
Knife cookbook create Demobook
•	Next we have to install  java and tomcat server using with associated files.

	vi   files/default/tomcat
package  'java'  do 
version ‘8.0’ 
action  :install
end
package “tomcat” do
action : install
end	
execute 'tomcat_configtest'  do
command '/usr/bin/.startup.sh'
end

	Vi  recipes/default.rb

    Cookbook_file  “ /user/bin” do
                 source “tomcat”
                 end

3. A Shell script which can be run in the workstation/sandbox that should do the following 
• Trigger the python script created in step1 
• Bootstrap the instance created with the cookbook developed at step2 to install and run the Tomcat server. 

•	To create one shell script file and associated python file and bootstrap in node.
	vi  task.sh
# !/bin/bash
Python  ec2launch.py
knife bootstrap  10.126.34.0 --sudo  -x  ec2-user  -i /root/Chefkey.pem  -N "node1"  -r                                 "recipe[Demobook]"

4. A Docker file to achieve the following .
• Install Chef Development kit https://downloads.chef.io/chefdk. 
• Configure knife with the Chef+ server url provided in the input file. (Assume that Chef server is already available) 

•	By using Docker file to create ChefDk image, copying a chef-starter   from S3 bucket, unzip the starterkit and knife configure with the chef server.

	Vi  Dockerfile
                     FROM   Ubuntu
                     RUN    Wget  https://packages.chef.io/files/stable/chefdk/1.4.3/ubuntu/16.04/chefdk_1.4.3-1_amd64.deb  
                                 && apt-get install chefdk_1.4.3-1_amd64.deb && apat-get install vim –y 
                     CMD    aws  s3  cp  s3://chef_bucket/ chef-starter.zip     /root
                     UNZIP  chef-starter.zip
                     CMD     knife  configure client chef-repo

•	To Create Docker container and Login into that container.
               Docker run  -dti –name   test  -v  /root/ops:/tmp     ubuntu  /bin/bash
               Docker attach test 
•	To Create Directory and move to /Ops/ path.
Mkdir    ops
                Mv      /root/task.sh  /root/ops

  • Bake the Shell script created in step3 into the Docker container.

•	To install Python in Docker container after configure bake shell in our container.
      python  -V
                   ubuntu > sudo apt-get install python
                  > bake.py check

•	Create a bake repository on the directory you are in now

              ubuntu > sudo apt-get install mercurial

•	Change directory into the bake directory. 

              > hg clone http://code.nsnam.org/bake bake> export BAKE_HOME=`pwd`
             > export PATH=$PATH:$BAKE_HOME:$BAKE_HOME/build/bin
             > export PYTHONPATH=$PYTHONPATH:$BAKE_HOME:$BAKE_HOME/build/lib
             > bake.py configure -e ns-3-dev
             > bake.py -f nonStandardName.xml configure -c $BAKE_HOME/bakefile.xml -e ns-3-allinone --                                      installdir=/tmp/installBake --sourcedir=/tmp/sourceBake
           > bake.py deploy
           > bake.py download

•	By using Bake file to  install Shutil and copy the Task file.

•	Using bake file to copy the task.ssh file

 vi  bake.py
               import shutil
               shutil.copy2('/ops/task.sh',   ‘/tmp/task.sh')

•	To Create new Demo shell file and run the bake file by Vi Editor.
•	To Create demo.sh file and run the ec2 instance and bootstrap node using bake.py

	vi  demo.sh
                            # !/bin/bash
                             python bake.py
                             execute shell script : ./demo.sh

