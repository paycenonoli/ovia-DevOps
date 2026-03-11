# Choose a base image
FROM ubuntu:24.04

# Install necessary packages
RUN apt-get -y update && apt-get -y install python3 python3-pip python3.12-venv

# Set the  working directory inside container
WORKDIR /opt

# Copy dependencies
COPY ./requirements.txt .

# Create a virtual environment
RUN python3 -m venv /opt/devops-python

# Install Python dependencies using virtual environment
RUN /opt/devops-python/bin/pip install --upgrade pip \
    && /opt/devops-python/bin/pip install -r requirements.txt

# Copy the application code
COPY ./app.py .

# Set environments
ENV FLASK_APP=/opt/app.py
ENV PATH="/opt/devops-python/bin:$PATH"

# Port
EXPOSE 8080

# Start application
CMD ["/opt/devops-python/bin/flask", "run", "--host=0.0.0.0", "--port=8080"]
