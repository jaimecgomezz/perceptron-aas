#!/usr/bin/env sh

# POST /train
curl --request POST \
  --url http://localhost:9292/train \
  --header 'Content-Type: application/json' \
  --data '{
	"inputs": [
		[0, 0],
		[0, 1],
		[1, 0],
		[1, 1]
	],
	"targets": [
		0,
		0,
		0,
		1
	],
	"config": {
		"alpha": 0.1,
		"dimension": 2
	}
}'

# POST /train
curl --request POST \
  --url http://localhost:9292/predict \
  --header 'Content-Type: application/json' \
  --data '{
  "input": [
    1,
    1
  ],
  "config": {
		"dimension": 2,
		"alpha": 0.1,
		"weights": [
			0.17049156980191243,
			0.14442368350208507,
			-0.29589168632546364
		]
	}
}'
