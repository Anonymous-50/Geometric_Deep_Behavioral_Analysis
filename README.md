# **A Skeleton-based Geometric Deep Neural Network for Alzheimer’s Disease Mice Behavioral Analysis**


## Abstract
<div style="text-align: justify"> 
Alzheimer’s disease (AD) is a progressive and irreversible brain disorder that remains incurable. Research has shown a strong link between gait and cognition, with AD significantly affecting gait and behavioral patterns. While most preclinical studies analyze gait using mice pawprints, this approach is prone to inconsistencies due to variations in pawprints' correction by different experimenters. In contrast, skeleton-based behavioral analysis provides a more consistent and cleaner representation. In this work, we collect a new mice dataset and propose a novel skeleton-based geometric deep attention network for disease classification using the mice's behavioral information from this dataset. We begin our analysis by extracting posture data as skeleton landmark sequences which are then processed by our proposed network for the classification. Our proposed approach demonstrates promising results, making it particularly relevant for preclinical gait research and we conduct an extensive ablation study on our proposed approach to demonstrate its effectiveness.
</div>

## Sample Video and Pose Tracking 
We use the the DeepLabCut (DLC) animal pose tracking toolbox to extract the mice posture from our video dataset. For all instructions on installation and usage of the DLC toolboox, visit their Github page [Here](https://github.com/DeepLabCut/DeepLabCut/tree/main)

<img src="samples/combine.gif" style="width:100%; height:auto;">

## Packages and Dependencies
- For packages and dependencies, first create an enviroment using Python, activate the enviroment and run "pip install -r requirements.txt"

## Data Preparation 
- In the 'data_preparation' folder contains the files for preparing the pose skeleton files before feeding them to the geometric deep framework.

## Data Loading 
- In the 'data_loader' folder contains the files for loading as binary or triple classification tasks.

## Training
- For the network training, use the file 'train_LOOCV_b' or 'train_LOOCV_m' for binary or multi-class respectively.

## Angular velocity
- Use the 'compute_ang_velocity' file. 

