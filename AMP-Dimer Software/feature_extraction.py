import pandas as pd
import re
from Bio.SeqUtils.ProtParam import ProteinAnalysis

class AMP:
    def __init__(self, name, sequence):
        self.name = name
        self.sequence = sequence

def load_data(file_path):
    data = pd.read_csv(file_path)
    print("First few rows of the dataset:")
    print(data.head())

    print("\nDataset Information:")
    print(data.info())

    print("\nSummary Statistics:")
    print(data.describe())
    return data

def escape_special_characters(name):
    return re.escape(name)

def check_amp_in_dataset(data, amp_list):
    for amp in amp_list:
        name_present = any(data['NAME'].str.contains(escape_special_characters(amp.name), na=False))
        sequence_present = any(data['SEQUENCE'].str.contains(amp.sequence))
        if name_present and sequence_present:
            print(f"Sequence {amp.sequence} with name {amp.name} found in dataset")
        else:
            print(f"Sequence {amp.sequence} with name {amp.name} not found in dataset")

def extract_features(sequence):
    analyzed_seq = ProteinAnalysis(sequence)
    features = {
        'length': len(sequence),
        'molecular_weight': analyzed_seq.molecular_weight(),
        'aromaticity': analyzed_seq.aromaticity(),
        'instability_index': analyzed_seq.instability_index(),
        'isoelectric_point': analyzed_seq.isoelectric_point(),
        'gravy': analyzed_seq.gravy()
    }
    return features

def generate_amp_features(data, amp_list):
    random_indices = random.sample(range(len(data)), 5)  # randomly select 5 indices from the dataset
    for idx in random_indices:
        name = data.iloc[idx]['NAME']
        sequence = data.iloc[idx]['SEQUENCE']
        amp_list.append(AMP(name, sequence))

    amp_features = [extract_features(amp.sequence) for amp in amp_list]

    amp_features_df = pd.DataFrame(amp_features)
    amp_features_df['name'] = [amp.name for amp in amp_list]
    amp_features_df['sequence'] = [amp.sequence for amp in amp_list]

    print("Extracted Features:")
    print(amp_features_df)
    return amp_features_df
