#!/bin/bash

#put here the name of your caffe distribution
export CAFFE_ROOT=$HOME/src/caffe_python_2

# remove previous installs
sudo unlink /home/ubuntu/src/caffe_python_2/distribute/bin/caffe.bin
sudo unlink /home/ubuntu/src/caffe_python_2/distribute
sudo unlink /home/ubuntu/src/caffe_python_2/build/install/bin/compute_image_mean.bin


##################################################################################
# set caffe dir
mkdir $HOME/caffe_tools
mkdir $HOME/caffe_tools/BVLC1v0-Caffe

sudo ln -nsf /home/ubuntu/src/caffe_python_2/                           $CAFFE_ROOT
#export CAFFE_ROOT=$CAFFE_ROOT_DIR/caffe_python_2
sudo ln -nsf /home/ubuntu/src/caffe_python_2/build/install              $CAFFE_ROOT/distribute
sudo ln -nsf /home/ubuntu/src/caffe_python_2/build/install/bin/caffe    $CAFFE_ROOT/distribute/bin/caffe.bin
sudo ln -nsf /home/ubuntu/src/caffe_python_2/build/install/bin/compute_image_mean $CAFFE_ROOT/distribute/bin/compute_image_mean.bin

##################################################################################
# make all *.sh scripts to be executable
##https://askubuntu.com/questions/484718/how-to-make-a-file-executable
for file in $(find $HOME/ML/ -name *.sh); do
	chmod +x ${file}
done

##################################################################################
# set DNNDK dir, assuming $HOME/ML exists already
if [ ! -d $HOME/ML/DNNDK ]; then
	mkdir $HOME/ML/DNNDK
	cd $HOME
	cp xlnx_host_208tools_cuda9.tar.gz $HOME/ML/DNNDK
	
	cd $HOME/ML/DNNDK
	tar -xvf xlnx_host_208tools_cuda9.tar.gz
	cd ./cuda9_tools
	cp $HOME/ML/cifar10/aws_scripts/libyaml* .

	ln -nsf $HOME/ML/DNNDK/cuda9_tools/dnnc-dpu1.3.0 $HOME/ML/DNNDK/cuda9_tools/dnnc
	ln -nsf $HOME/ML/DNNDK/cuda9_tools $HOME/ML/DNNDK/tools
fi

##################################################################################
# install missing packages on the AWS
source activate tensorflow_p27
conda install keras
source deactivate tensorflow_p27
source activate caffe_p27
conda install python-lmdb pydot scikit-learn
source deactivate caffe_p27


#################################################################################
#remove all *.tar files

#cd /$HOME/ML/DNNDK
#rm *.tar*

#################################################################################
#try decent and dnnc

source $HOME/ML/cifar10/aws_scripts/aws_activate_dnndk_cuda9.sh
decent --version
dnnc --version

