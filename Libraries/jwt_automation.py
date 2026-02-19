import os
import jwt

header = {  
	"alg": "HS256",
	"typ": "JWT"
}

payload = {  
	"subject": "this is a automated test that just test for kidding around with jwt token generation and show the joke message in the payload"
}

secret = os.getenv('TEST_SECRET_JWT_KEY') or os.getenv('JWT_KEY')

def generate_jwt(message_base64=None):
	current_payload = payload
	if message_base64:
		if isinstance(message_base64, str):
			current_payload = {"message_base64": message_base64}
		else:
			current_payload = message_base64
	encoded_jwt = jwt.encode(current_payload, secret, algorithm='HS256', headers=header)
	return encoded_jwt

def verify_and_decode_jwt(token, provided_secret):
	try:
		decoded = jwt.decode(token, provided_secret, algorithms=['HS256'])
		return decoded, True
	except jwt.InvalidSignatureError:
		return None, False
	except Exception:
		return None, False
