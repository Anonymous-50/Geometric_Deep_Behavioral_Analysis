import torch
import torch.nn as nn
import torch.nn.functional as F
import torchgeometry.core as tgmc

cuda = torch.cuda.is_available()
device = 'cuda' if cuda == True  else 'cpu'

def rotation_matrix_from_angle(theta):
    rot_matrix_ = torch.empty(0, 2, 2)
    for i in range(theta.shape[0]):
        cos_theta = torch.cos(theta[i])
        sin_theta = torch.sin(theta[i])

        res = torch.tensor([[cos_theta, -sin_theta],
                     [sin_theta, cos_theta]])
        rot_matrix_ = torch.cat((rot_matrix_, res.unsqueeze(0)), dim=0)
        return rot_matrix_

class RigidTransform(nn.Module):
    def __init__(self, num_frames, num_joints, run=0):
        super().__init__()
        self.num_frames, self.joints = num_frames, num_joints
        torch.manual_seed(run)
        angles = torch.Tensor(self.num_frames,1)        
        nn.init.uniform_(angles, a =-0.3,b=0.3)
        self.weights = nn.Parameter(angles) 

    def forward(self, x):
        self.weights_ = rotation_matrix_from_angle(self.weights).to(device)  
        w_times_x_ = torch.matmul(x[:,:,0:8],self.weights_) 
        new_x = x.clone()                                  
        new_x[:,:,0:8] = w_times_x_                    
        w_times_x = new_x
        return w_times_x

