# Perceptron As a Service

Train your Perceptron As a Service

## Requirements

1. [rbenv](https://github.com/rbenv/rbenv): A version manager for the Ruby language
2. [ruby-build](https://github.com/rbenv/ruby-build): A command-line tool that simplifies installation of any Ruby language version

## Installation

1. Once `rbenv`and `ruby-build`have been installed, we must install the `3.0.3` version of Ruby:

   ```sh
   $ rbenv install 3.0.3
   ```

2. Verify that the correct version of Ruby is installed:

   ```sh
   $ ruby --version
   # Expected output:
   ruby 3.0.3p157 (2021-11-24 revision 3fb7d2cadc)
   ```

3. Install the project dependencies with [bundler](https://bundler.io/):

   ```sh
   $ bundle install
   ```

4. Start the local API with [puma](https://github.com/puma/puma):

   ```sh
   $ bundle exec puma deploy/config.ru
   # Expected output:
   Puma starting in single mode...
   * Puma version: 6.4.2 (ruby 3.0.3-p157) ("The Eagle of Durango")
   *  Min threads: 0
   *  Max threads: 5
   *  Environment: development
   *          PID: 82956
   * Listening on http://0.0.0.0:9292
   Use Ctrl-C to stop
   ```

   

## Usage

For this example, we'll use a standard `perceptron` training example, the `AND` logic gate. We expect our trained perceptron to stablish the logic relations of the `AND` gate given 2 boolean inputs (`1`, `0`) such that:

|  X1  |  X2  | AND  |
| :--: | :--: | :--: |
|  0   |  0   |  0   |
|  0   |  1   |  0   |
|  1   |  0   |  0   |
|  1   |  1   |  1   |



### Train

This endpoint allows the user to train a perceptron. Following the `AND` gate example, the request should look as follows:

`````` json
# POST /train
{
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
}
``````

The expected response from the API should look like this:

``````json
{
	"result": {
		"dimension": 2,
		"alpha": 0.1,
		"weights": [
			0.17049156980191243,
			0.14442368350208507,
			-0.29589168632546364
		]
	}
}
``````

The previous response represents the resulting `weights` of the perceptron `inputs`, as described in the perceptron model. Said response isn't helpful all by itself, we'll need to it into the `predict` endpoint in order to validate the perceptron training.

### Predict

``````json
# POST /predict
{
  "input": [1, 1],
  "config": {
		"dimension": 2,
		"alpha": 0.1,
		"weights": [
			0.17049156980191243,
			0.14442368350208507,
			-0.29589168632546364
		]
	}
}
``````

Now, the expected response from the API looks like this:

```json
{ "result": 1 }
```

What we just did is requesting to evaluate our `input` with the provided `config`, which is nothing but the result of the train request made earlier. The `X1: 1, X2: 1` input results in a `1`output, as stated in the table defined above. We'll now make another request with the `input` being: `X1: 0, X2: 1`, which should result in a `0` output.

 ```json
 # POST /predict
 {
   "input": [0, 1],
   "config": {
 		"dimension": 2,
 		"alpha": 0.1,
 		"weights": [
 			0.17049156980191243,
 			0.14442368350208507,
 			-0.29589168632546364
 		]
 	}
 }
 ```

As expected, the API response is the following:

```json
{ "result": 0 }
```

