# Use an official lightweight Python image as a base
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies required for OpenCV
RUN apt-get update && \
    apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the best.pt file explicitly using the relative path
COPY best.pt /app/best.pt

# Copy other project files explicitly
COPY app.py /app/app.py

# Expose the port that the FastAPI app will run on
EXPOSE 8080

# Command to run the FastAPI application with Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]


# docker ps -a     to check all containers running or stoped
# docker start <container_id_or_name>    to start container 
# docker stop  <container_id_or_name>   to stop container
 