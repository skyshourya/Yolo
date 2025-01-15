from fastapi import FastAPI, File, UploadFile
from ultralytics import YOLO
from io import BytesIO
from PIL import Image
import numpy as np
from collections import Counter  # Import Counter

# Load the YOLO model
model = YOLO("./best.pt")

# Initialize the FastAPI app
app = FastAPI()

# Add a root endpoint to show a welcome message
@app.get("/")
async def read_root():
    return {"message": "Welcome to the YOLO prediction API!"}

# Add the /predict endpoint to handle image uploads
@app.post("/predict/")
async def predict(file: UploadFile = File(...)):
    # Open the image from the uploaded file
    image_data = await file.read()
    image = Image.open(BytesIO(image_data))
    
    # Preprocess the image to match input size
    image = image.resize((640, 640))  # Resize to 640x640
    image_np = np.array(image).astype(np.float32) / 255.0  # Normalize to [0, 1]
    image_np = np.transpose(image_np, (2, 0, 1))  # Convert to (channels, height, width)
    image_np = np.expand_dims(image_np, axis=0)  # Add batch dimension
    
    # Run inference on the image
    results = model(image)

    # Extract and count detected classes
    detected_classes = []
    for r in results:
        for box in r.boxes:
            class_name = model.names[int(box.cls)]
            detected_classes.append(class_name)
    
    # Count the occurrences of each class
    class_counts = Counter(detected_classes)  # Count occurrences
    formatted_output = [f"{count} {cls_name}" for cls_name, count in class_counts.items()]
    final_output = ", ".join(formatted_output)

    return {"prediction": final_output}


# source venv/bin/activate for mac
# python3 -m venv venv for windows
# uvicorn app:app --host 127.0.0.1 --port 8080  to run http://127.0.0.1:8080/docs
