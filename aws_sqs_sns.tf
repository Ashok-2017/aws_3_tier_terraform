resource "aws_sqs_queue" "sqs_astro" {
  name = "sqs_astro"
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue" "sqs_astro_dlq" {
  name = "sqs_astro_dlq"
}

resource "aws_sqs_queue_redrive_policy" "sqs_astro_redrive_policy" {
  queue_url = aws_sqs_queue.sqs_astro.id

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_astro_dlq.arn
    maxReceiveCount = 4 
})
depends_on = [
    aws_sqs_queue.sqs_astro,
    aws_sqs_queue.sqs_astro_dlq
  ]
}

resource "aws_sqs_queue_redrive_allow_policy" "sqs_astro_dlq_redrive_allow_policy" {
  queue_url = aws_sqs_queue.sqs_astro_dlq.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.sqs_astro.arn]
  })

  depends_on = [
    aws_sqs_queue.sqs_astro,
    aws_sqs_queue.sqs_astro_dlq
  ]
}

resource "aws_sns_topic" "sns_dlq_notification" {
  name = "sns_dlq_notification"
}

resource "aws_sns_topic_subscription" "sns_astro_subscription" {
  topic_arn = aws_sns_topic.sns_dlq_notification.arn
  protocol  = "email"
  endpoint  = "ashokrdy51@gmail.com"
}




  
