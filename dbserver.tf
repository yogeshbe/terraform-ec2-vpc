/* resource "aws_db_subnet_group" "dbsubnetgroup" {
  name        = "rds-subnet-group"
  description = "Our main group of subnets"
  subnet_ids  = ["${aws_subnet.us-east-2b-private.id}", "${aws_subnet.us-east-2c-private.id}"]
  tags {
    Project = "wordpress"
  }
}


resource "aws_db_instance" "wpdb" {
  depends_on             = ["aws_security_group.web"]
  identifier             = "wpdb"
  allocated_storage      = "5"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "wpdb"
  username               = "root"
  password               = "rootroot"
  multi_az               = "false"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.dbsubnetgroup.id}"
  tags {
    Project = "wordpress"
  }
}

output "rdshost" {
  
  value = "${aws_db_instance.wpdb.address}"

} */
