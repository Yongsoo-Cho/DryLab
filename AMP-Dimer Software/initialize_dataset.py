"""SynBio
Script by Mike Cho. Initialziing dataset class.
"""


import torch
from torch.utils.data import Dataset

class AMPDataSet(Dataset):
    def __init__(self, data, targets, transform=None):
        """
        Args:
            data: List of features.
            targets: List of target labels (true/false).
            transform (callable, optional): Optional transform to be applied on a sample.
        """
        self.data = data
        self.targets = targets
        self.transform = transform

    def __len__(self):
        return len(self.data)

    def __getitem__(self, idx):
        if torch.is_tensor(idx):
            idx = idx.tolist()

        sample = {'data': self.data[idx], 'target': self.targets[idx]}

        if self.transform:
            sample = self.transform(sample)

        return sample



import numpy as np
# Dummy Data
data = np.random.rand(100, 10)  # 100 samples, 10 features each (features yet to be defined but pertain to biophysical properties)
targets = np.random.randint(0, 2, size=(100,)) #True, False, Null

dataset = AMPDataSet(data, targets)
