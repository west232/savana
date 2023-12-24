locals {
  lambda_zip_location = "output/lambda_function.zip"
}

data "archive_file" "zip_code" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = local.lambda_zip_location

}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "layer.zip"
  layer_name = "savana_test_layer"

  compatible_runtimes = ["python3.12"]
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "savana_lambda_function"
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler"
  filename      = local.lambda_zip_location
  layers        = [aws_lambda_layer_version.lambda_layer.arn]

  role = aws_iam_role.lambda_role.arn
  vpc_config {
    subnet_ids         = module.subnets.subnet_id
    security_group_ids = [module.securitygroup.seg_id[0]]
  }
  file_system_config {
    arn              = aws_efs_access_point.access_point_for_lambda.arn
    local_mount_path = "/mnt/test"

  }

  timeout     = 900
  memory_size = 1050

  environment {
    variables = {
      Name = "savana_lambda_function"
      ENV  = "DEV"
    }
  }

  depends_on = [
    aws_efs_mount_target.efsm_pub,
    aws_efs_mount_target.efsm_priv
  ]
}
resource "aws_lambda_permission" "allow_invocation" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name

  principal = "apigateway.amazonaws.com"
}
# EFS for all region
resource "aws_efs_file_system" "efs_for_lambda" {
  availability_zone_name = null
  performance_mode       = "generalPurpose"
  throughput_mode        = "bursting"
  encrypted              = true
  tags = {
    Name = "efs_for_lambda"
  }
}
# EFS access point used by lambda file system
resource "aws_efs_access_point" "access_point_for_lambda" {
  file_system_id = aws_efs_file_system.efs_for_lambda.id

  root_directory {
    path = "/lambda"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }

  posix_user {
    gid = 1000
    uid = 1000
  }
}

# Mount target connects the file system to the subnet
resource "aws_efs_mount_target" "efsm_pub" {
  file_system_id  = aws_efs_file_system.efs_for_lambda.id
  subnet_id       = data.aws_subnet.pub_savana.id
  security_groups = [module.securitygroup.seg_id[0]]
}

resource "aws_efs_mount_target" "efsm_priv" {
  file_system_id  = aws_efs_file_system.efs_for_lambda.id
  subnet_id       = data.aws_subnet.priv_savana.id
  security_groups = [module.securitygroup.seg_id[0]]
}
  