FROM python:3-slim

WORKDIR /web

COPY . /web

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80/tcp

# Run app.py when the container launches
CMD ["python", "./app.py"]
