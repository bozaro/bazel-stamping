def _stamping_impl(ctx):
    out = ctx.outputs.out
    src = ctx.file.src
    ctx.actions.run_shell(
        outputs = [out],
        inputs = [src, ctx.version_file],
        command = "md5sum {} {} > {}".format(src.path, ctx.version_file.path, out.path),
    )
    return [DefaultInfo(
        files = depset([out]),
    )]

stamping = rule(
    implementation = _stamping_impl,
    attrs = {
        "out": attr.output(mandatory = True),
        "src": attr.label(allow_single_file = True, mandatory = True),
    },
)
