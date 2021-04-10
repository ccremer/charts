## Upgrading from 0.x charts

There are some breaking changes from 0.x to 1.x versions.

* The `storageclass.classes` array is now empty.
  Where it previously contained an example, the example is removed as a default value.
  The example is still in `values.yaml` in form of YAML comments.
* The `image.registry` has changed from `docker.io` to `quay.io` due to Docker Hub's pull limit.
* Bumped `image.tag` to `v1.0.0`
