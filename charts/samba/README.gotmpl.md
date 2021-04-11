## Limitations

`samba.shares` and `samba.users` are translated into indexed environment variables, e.g. `SHARE0` and `USER0`.
Unfortunately, there cannot be an 11th share or user definition, as `SHARE10` gets confused with `SHARE1` (and likewise with `USERx`).

To workaround this limitation, use the `samba.args` and construct the definitions on your own using the script arguments.
Refer to [dperson/samba](https://github.com/dperson/samba) on how to do this.
