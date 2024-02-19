# Perceptron As a Service

Train your Perceptron As a Service

## Requirements

This guide will focus entirely on the `perceptron-aas` project dependencies installation and usage, is the up to the user to install the following requirements: 

1. [git](https://git-scm.com/downloads): A  free and open source distributed version control system
2. [rbenv](https://github.com/rbenv/rbenv?tab=readme-ov-file#installation): A version manager for the Ruby language
3. [ruby-build](https://github.com/rbenv/ruby-build?tab=readme-ov-file#installation): A command-line tool that simplifies installation of any Ruby language version

## Installation

1. Download this repository

   ```sh
   $ git clone https://github.com/jaimecgomezz/perceptron-aas.git
   cd perceptron-aas
   ```

2. Install the `3.0.3` version of Ruby with `rbenv` and `ruby-build`:

   ```sh
   $ rbenv install 3.0.3
   ```

3. Verify that the correct version of Ruby is installed:

   ```sh
   $ ruby --version
   ruby 3.0.3p157 (2021-11-24 revision 3fb7d2cadc)
   ```

4. Install the project dependencies with [bundler](https://bundler.io/):

   ```sh
   $ bundle install
   ```

5. Start the local API with [puma](https://github.com/puma/puma):

   ```sh
   $ bundle exec puma deploy/config.ru
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



### Train [POST /train]

This endpoint allows the user to train a perceptron. Following the `AND` gate example, the request should look as follows:

`````` json
{
  "inputs":[
    [0,0],
    [0,1],
    [1,0],
    [1,1]
  ],
  "targets":[
    0,
    0,
    0,
    1
  ]
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

The previous response represents the resulting `weights` of the perceptron `inputs`, as described in the perceptron model. Said response isn't helpful all by itself, we'll need to feed it into the `predict` endpoint in order to validate the perceptron training.

### Predict [POST /predict]

``````json
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

What we just did is requesting to evaluate our `input` with the provided `config`, which is nothing but the result of the train request made earlier. The `X1: 1, X2: 1` input results in a `1`output, as stated in the table defined at the top. We'll now make another request with the `input` being: `X1: 0, X2: 1`, which should result in a `0` output.

 ```json
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

Since the previous response turned out correct, we should be able to validate the remaining `X1` and `x2` configurations, expecting the correct output, which will be left as an exercise for the user:

- `X1: 1`, `X2: 0` should return `0`
- `X1: 0`, `X2: 0` should return `0`

## Documentation

### API reference

This project is documented using the [OpenAPI specification](https://swagger.io/specification/) which is widely considered as the standard for API specification. Said documentation is available within the project, inside the `reference` directory as a standard [OpenAPI JSON document](reference/perceptron-aas.json), an [HTML web page](reference/perceptron-aas.html) or a simple [PDF file](reference/perceptron-aas.pdf).

### Requests

The examples above (`train`, `predict`) are also contained within the project, inside the `requests` directory, as a [Insomnia](https://insomnia.rest/) [requests collection](requests/insomnia.json) or as a [cURL](https://curl.se/) [script](requests/curl.sh).
