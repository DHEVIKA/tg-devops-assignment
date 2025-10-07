import boto3
import pandas as pd
import os

def main():
    s3 = boto3.client("s3")

    raw_bucket = os.getenv("RAW_BUCKET", "raw-data-d71b2bb5")
    processed_bucket = os.getenv("PROCESSED_BUCKET", "processed-data-d71b2bb5")
    input_key = os.getenv("INPUT_KEY", "input.csv")
    output_key = os.getenv("OUTPUT_KEY", "output.csv")

    local_input = "/tmp/input.csv"
    local_output = "/tmp/output.csv"

    print(f"Downloading {input_key} from {raw_bucket}...")
    s3.download_file(raw_bucket, input_key, local_input)

    df = pd.read_csv(local_input)
    if "name" in df.columns:
        df["name"] = df["name"].str.upper()

    df.to_csv(local_output, index=False)
    s3.upload_file(local_output, processed_bucket, output_key)
    print(f"Uploaded {output_key} to {processed_bucket}")

if __name__ == "__main__":
    main()

