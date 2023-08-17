# vitess-docker-aarch64
Docker Images for Vitess working on aarch64 (aka Apple Silicon)

## Using the image

The image is fully compatible with the [standard vttestserver image](https://vitess.io/docs/16.0/get-started/vttestserver-docker-image/). You can [run it](https://vitess.io/docs/16.0/get-started/vttestserver-docker-image/#run-the-docker-image) the same way as the upstream image. The only difference is that it works on a Mac with Apple Silicon CPUs.

An example command to run the image is available in the `run-example.sh` file.

## Release Process

1. Update the MySQL, Vitess or Go versions in `versions.sh`
2. Run `build.sh`
3. Run `run-example.sh` and verify that the server works
4. Run `push.sh` to release the image
5. Commit and push the changes GitHub
