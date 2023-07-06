# Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Update with your desired region
}

# Create an S3 bucket for storing raw data
resource "aws_s3_bucket" "raw_data_bucket" {
  bucket = "my-raw-data-bucket"  # Update with your preferred bucket name
  acl    = "private"
}

# Create an S3 bucket for storing processed data
resource "aws_s3_bucket" "processed_data_bucket" {
  bucket = "my-processed-data-bucket"  # Update with your preferred bucket name
  acl    = "private"
}

# Create an AWS Glue database
resource "aws_glue_catalog_database" "database" {
  name = "my_database"  # Update with your preferred database name
}

# Create an AWS Glue crawler to discover the data schema
resource "aws_glue_crawler" "crawler" {
  name            = "my_crawler"  # Update with your preferred crawler name
  database_name   = aws_glue_catalog_database.database.name
  role            = "arn:aws:iam::123456789012:role/my-crawler-role"  # Update with your IAM role ARN
  s3_targets {
    path = "s3://${aws_s3_bucket.raw_data_bucket.bucket}/"  # Path to your raw data bucket
  }
}

# Create an AWS Glue job to transform the data
resource "aws_glue_job" "job" {
  name          = "my_job"  # Update with your preferred job name
  role          = "arn:aws:iam::123456789012:role/my-job-role"  # Update with your IAM role ARN
  command {
    name        = "glueetl"
    python_version = "3"
    script_location = "s3://path/to/your/glue_script.py"  # Path to your Glue ETL script
  }
  default_arguments = {
    "--TempDir"       = "s3://${aws_s3_bucket.processed_data_bucket.bucket}/temp/"  # Temporary directory for processing data
    "--database_name" = aws_glue_catalog_database.database.name
  }
  depends_on = [aws_glue_crawler.crawler]
}

# Create an AWS Glue table to represent the processed data
resource "aws_glue_catalog_table" "table" {
  name            = "my_table"  # Update with your preferred table name
  database_name   = aws_glue_catalog_database.database.name
  table_type      = "EXTERNAL_TABLE"
  parameters = {
    "classification"    = "csv"  # Update with your file format if different
    "delimiter"         = ","
    "skip.header.line.count" = "1"  # Update if your data file has header
    "typeOfData"        = "file"
    "updateMatchingPartitions" = "false"
    "external.table.purge"      = "true"
  }

  }

  storage_descriptor {
    location = "s3://${aws_s3_bucket.processed_data_bucket.bucket}/"  # Path to your processed data bucket
    serde_info {
      name                  = "my_serde"
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"  # Update if your file format is different
      parameters = {
        "separatorChar" = ","
        }
    }

  }

    columns {
      name = "column1"
      type = ""
    }
