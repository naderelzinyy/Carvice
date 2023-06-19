import json
from channels.generic.websocket import AsyncWebsocketConsumer


class RequestConsumer(AsyncWebsocketConsumer):

    async def connect(self):
        print("Client connected")
        mechanic_id = self.scope['url_route']['kwargs']['mechanic_id']
        print(f"{mechanic_id = }")
        self.group_name = f'mechanic_{mechanic_id}'
        await self.channel_layer.group_add(self.group_name, self.channel_name)
        await self.accept()
        print(f"{self.group_name = }")
        # await self.channel_layer.group_send(message={"type": "receive_req"}, group=self.group_name)

    async def receive_request(self, event):
        print(f"{event = }")
        # received_request = json.loads(event)
        event["type"] = "show_request"
        await self.send(text_data=json.dumps(event))

    async def receive_offer(self, event):
        print(f"{event = }")
        # received_request = json.loads(event)
        event["type"] = "show_offer"
        await self.send(text_data=json.dumps(event))

    async def refuse_request(self, event):
        print(f"{event = }")
        event["type"] = "refuse_request"
        await self.send(text_data=json.dumps(event))

    async def refuse_offer(self, event):
        print(f"{event = }")
        event["type"] = "refuse_offer"
        await self.send(text_data=json.dumps(event))

    async def receive(self, text_data=None, bytes_data=None):
        print("receive starts")
        data = json.loads(text_data)
        print(f"{data = }")
        await self.channel_layer.group_send(message=data, group=self.group_name)

    def disconnect(self, code):
        print("client disconnected")
