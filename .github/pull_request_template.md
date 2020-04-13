<!--
Thank you for contributing to ccremer/charts. Before you submit this PR I'd like to
make sure you are aware of our technical requirements and best practices:

* https://github.com/helm/charts/blob/master/CONTRIBUTING.md#technical-requirements
* https://github.com/helm/helm/tree/master/docs/chart_best_practices

Please make sure that you let https://github.com/norwoodj/helm-docs generate the
documentation. You can do that by running

    docker run --rm -v $(pwd):/src -w /src -u $(id -u) jnorwood/helm-docs

This will create a README.md based on the values.yaml file.
-->

#### What this PR does / why we need it:

* Short summary

#### Checklist
<!-- Place an '[x]' (no spaces) in all applicable fields. Please remove unrelated fields. -->
- [ ] Chart Version bumped
- [ ] Variables are documented in the values.yaml as required in [Helm-Docs](https://github.com/norwoodj/helm-docs#valuesyaml-metadata)

  Run `docker run --rm -v $(pwd):/src -w /src -u $(id -u) jnorwood/helm-docs` to generate the README.md

- [ ] Title of the PR contains starts with chart name e.g. `[chart]`
