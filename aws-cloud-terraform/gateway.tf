resource "aws_apigatewayv2_api" "gateway" {
  name          = "test-http-api"
  protocol_type = "HTTP"
}