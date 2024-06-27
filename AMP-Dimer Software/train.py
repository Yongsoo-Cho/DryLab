import torch
from torch.utils.data import DataLoader
from amp_dataset import AMPDataSet
from logistic_regression import LogisticRegressionModel

def train_model(data, targets, input_dim, num_epochs=20, batch_size=16, learning_rate=0.01):
    # Create dataset and data loader
    dataset = AMPDataSet(data, targets)
    dataloader = DataLoader(dataset, batch_size=batch_size, shuffle=True)

    # Define model
    model = LogisticRegressionModel(input_dim)

    # Define loss and optimizer
    criterion = nn.BCELoss()  # Binary Cross Entropy Loss
    optimizer = torch.optim.SGD(model.parameters(), lr=learning_rate)

    # Training loop
    for epoch in range(num_epochs):
        for batch in dataloader:
            inputs = batch['data']
            labels = batch['target'].view(-1, 1)  # Reshape for compatibility with BCE loss

            # Forward pass
            outputs = model(inputs)
            loss = criterion(outputs, labels)

            # Backward and optimize
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

        print(f'Epoch [{epoch+1}/{num_epochs}], Loss: {loss.item():.4f}')

    # Testing the model
    with torch.no_grad():
        correct = 0
        total = 0
        for batch in dataloader:
            inputs = batch['data']
            labels = batch['target']
            outputs = model(inputs)
            predicted = (outputs.data > 0.5).float()  # Convert probabilities to binary predictions
            total += labels.size(0)
            correct += (predicted.view(-1) == labels).sum().item()

        print(f'Accuracy of the model on the dataset: {100 * correct / total:.2f}%')

    return model
