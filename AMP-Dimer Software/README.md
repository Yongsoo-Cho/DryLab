The dry lab are working to create a classification model that predicts whether an input AMP sequence dimerizes within the chloroplast of cyanobacteria.

# AMP Dimerization Prediction

This project aims to predict whether antimicrobial peptides (AMPs) will dimerize in chloroplasts using a logistic regression model implemented in PyTorch.

## Project Structure

- `amp_dataset.py`: Contains the `AMPDataSet` class for handling the dataset.
- `logistic_regression.py`: Contains the `LogisticRegressionModel` class defining the logistic regression model.
- `train.py`: Contains the training and evaluation loop for the logistic regression model.
- `feature_extraction.py`: Contains the feature extraction logic.
- `main.py`: Entry point for the script execution.
- `requirements.txt`: Lists the required packages.
- `data/`: Directory for storing data files.

## Installation

1. Clone the repository.
2. Install the required packages using `pip`:
    ```
    pip install -r requirements.txt
    ```

## Usage

Run the `main.py` script to train and evaluate the logistic regression model:
