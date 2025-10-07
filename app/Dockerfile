FROM python:3.10-slim

WORKDIR /app
COPY process.py .

RUN pip install boto3 pandas

CMD ["python", "process.py"]

