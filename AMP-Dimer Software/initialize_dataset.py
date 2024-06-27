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

        sample = {'data': torch.tensor(self.data[idx], dtype=torch.float32),
                  'target': torch.tensor(self.targets[idx], dtype=torch.float32)}

        if self.transform:
            sample = self.transform(sample)

        return sample
