import json
import os
import boto3

dynamodb = boto3.resource('dynamodb')
sns = boto3.client('sns')

TABLE_NAME = os.environ.get('ORDERS_TABLE')
REPORTS_TOPIC_ARN = os.environ.get('REPORTS_TOPIC_ARN')

def lambda_handler(event, context):
    table = dynamodb.Table(TABLE_NAME)

    for record in event.get('Records', []):
        try:
            # body نص JSON داخلي في SQS message
            body = json.loads(record['body'])
            order_id = body.get('orderId')

            if not order_id:
                print("No orderId in message body:", body)
                continue

            print(f"Processing orderId: {order_id}")

            # استرجاع العنصر من DynamoDB
            resp = table.get_item(Key={'orderId': order_id})
            item = resp.get('Item')

            if not item:
                print(f"OrderId {order_id} not found in DynamoDB.")
                continue

            # تحديث حالة الطلب
            table.update_item(
                Key={'orderId': order_id},
                UpdateExpression='SET #s = :new_status',
                ExpressionAttributeNames={'#s': 'status'},
                ExpressionAttributeValues={':new_status': 'PROCESSING'}
            )
            print(f"Order {order_id} status updated to PROCESSING.")

            # إرسال رسالة SNS
            message = json.dumps({
                'orderId': order_id,
                'message': 'order and processing'
            })
            sns.publish(
                TopicArn=REPORTS_TOPIC_ARN,
                Message=message,
                Subject=f"Order {order_id} Processing"
            )
            print(f"SNS notification sent for order {order_id}.")

        except Exception as e:
            print(f"Error processing record: {record}")
            print(str(e))
