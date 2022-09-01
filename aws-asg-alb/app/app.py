from flask import Flask, render_template
import boto3
import socket

app = Flask(__name__)

@app.route('/')
def index():
    data = list()
    host_name = socket.gethostname()
    client = boto3.client('ec2', region_name='us-east-1')
    response = client.describe_instances()

    for r in response['Reservations']:
        for i in r['Instances']:
            data.append(
                {
                    'id': i['InstanceId'],
                    'state': i['State']['Name'],
                    'availability_zone': i['Placement']['AvailabilityZone'],
                }
            )
    return render_template('index.html', data=data, host_name=host_name)

if __name__ == "__main__":
    app.run(host='0.0.0.0')