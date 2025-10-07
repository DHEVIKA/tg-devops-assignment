data "aws_iam_policy_document" "eks_pod_s3_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.raw_data.arn,
      "${aws_s3_bucket.raw_data.arn}/*",
      aws_s3_bucket.processed_data.arn,
      "${aws_s3_bucket.processed_data.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "eks_pod_s3_policy" {
  name   = "eks-pod-s3-access"
  policy = data.aws_iam_policy_document.eks_pod_s3_policy.json
}

