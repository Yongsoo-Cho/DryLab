import os
import numpy as np
from feature_extraction import load_data, AMP, generate_amp_features
from train import train_model

if __name__ == "__main__":
    # Mount Google Drive (if running in Google Colab)
    try:
        from google.colab import drive
        drive.mount('/content/drive', force_remount=True)

        project_directory = '/content/drive/MyDrive/SynBio/'
        os.chdir(project_directory)
    except:
        pass

    # Load your data
    file_path = "/content/drive/MyDrive/SynBio/Images/peptides (1).csv"
    data = load_data(file_path)

    # Define AMP instances
    amp_list = [
        AMP("Citropin 1.1", "GLFDVIKKVASVIGGL")
    ]

    amp_features_df = generate_amp_features(data, amp_list)

    # Assuming there is a 'DIMERIZE' column in the dataset indicating whether the AMP dimerizes (True/False).
    # This still needs to be done. Placeholder code.
    # - alphafold 
    # - pymol
    # - etc
    dimer_labels = data['DIMERIZE'].map({True: 1, False: 0}).values

    # Prepare data for training
    features = amp_features_df.drop(columns=['name', 'sequence']).values
    targets = dimer_labels[:len(features)]  # Ensure the target length matches the feature length

    input_dim = features.shape[1]
    model = train_model(features, targets, input_dim, num_epochs=20, batch_size=16, learning_rate=0.01)

#where would you want to be in one week?

#more certainty, and more of a plan