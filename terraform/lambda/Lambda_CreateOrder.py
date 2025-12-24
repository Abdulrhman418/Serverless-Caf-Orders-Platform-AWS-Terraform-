import json
import os
import uuid
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
queue = boto3.client('sqs')

TABLE_NAME = os.environ.get('ORDERS_TABLE')
QUEUE_URL = os.environ.get('ORDERS_QUEUE_URL')

def lambda_handler(event, context):
    body = json.loads(event.get('body') or '{}')
    order_id = str(uuid.uuid4())
    item = {
        'orderId': order_id,
        'createdAt': datetime.utcnow().isoformat(),
        'customer': body.get('customer'),
        'items': body.get('items', []),
        'status': 'NEW'
    }

    table = dynamodb.Table(TABLE_NAME)
    table.put_item(Item=item)

    queue.send_message(QueueUrl=QUEUE_URL, MessageBody=json.dumps({'orderId': order_id}))

    return {
        'statusCode': 201,
        'headers': {
            'Access-Control-Allow-Origin': '*',  # أو '*' لو حابب تسمح لكل الدومينات
            'Access-Control-Allow-Headers': 'Content-Type,Authorization',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        'body': json.dumps({'orderId': order_id})
    }
