from fastapi import FastAPI, File, UploadFile
from ultralytics import YOLO
from io import BytesIO
from PIL import Image
import numpy as np
from collections import Counter 

model = YOLO("./best.pt")

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "Welcome to the YOLO prediction API!"}

@app.post("/predict/")
async def predict(file: UploadFile = File(...)):
    image_data = await file.read()
    image = Image.open(BytesIO(image_data))
    
    image = image.resize((640, 640)) 
    image_np = np.array(image).astype(np.float32) / 255.0 
    image_np = np.transpose(image_np, (2, 0, 1))  
    image_np = np.expand_dims(image_np, axis=0)  
    

    results = model(image)

    detected_classes = []
    for r in results:
        for box in r.boxes:
            class_name = model.names[int(box.cls)]
            detected_classes.append(class_name)
    

    class_counts = Counter(detected_classes) 
    formatted_output = [f"{count} {cls_name}" for cls_name, count in class_counts.items()]
    final_output = ", ".join(formatted_output)

    return {"prediction": final_output}



