
#IAM Roleの作成
resource "aws_iam_role" "my_role" {
    name = "terraform-role"
    
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
    })
    tags = {
        name = "my-role"
    }
}

# IAMロールにAdministratorAccessポリシーをアタッチ
resource "aws_iam_policy_attachment" "admin_access_attachment" {
  name       = "AdministratorAccessAttachment"
  roles      = [aws_iam_role.my_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# IAMユーザーの作成
resource "aws_iam_user" "my_user" {
  name = "my-user"

  tags = {
    Name = "my-user"
  }
}

# IAMユーザーにポリシーをアタッチ
resource "aws_iam_user_policy_attachment" "my_user_policy_attachment" {
  user       = aws_iam_user.my_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
