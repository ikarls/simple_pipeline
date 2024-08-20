__author__ = "Ida Karlsson"
__copyright__ = "Copyright 2024, Ida Karlsson"
__email__ = "ida.karlsson@scilifelab.uu.se"
__license__ = "GPL-3"


rule picard_add_comments_to_bam:
    input:
        input1="alignment/samtools_merge_bam/{sample}_T.bam",
    output:
        output1="alignment/picard_add_comments_to_bam/{sample}_{type}.comments.bam",
    params:
        extra=config.get("picard_add_comments_to_bam", {}).get("extra", ""),
    log:
        "alignment/picard_add_comments_to_bam/{sample}_{type}.output.log",
    benchmark:
        repeat(
            "alignment/picard_add_comments_to_bam/{sample}_{type}.output.benchmark.tsv",
            config.get("picard_add_comments_to_bam", {}).get("benchmark_repeats", 1)
        )
    threads: config.get("picard_add_comments_to_bam", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("picard_add_comments_to_bam", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("picard_add_comments_to_bam", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("picard_add_comments_to_bam", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("picard_add_comments_to_bam", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("picard_add_comments_to_bam", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("picard_add_comments_to_bam", {}).get("container", config["default_container"])
    message:
        "{rule}: add comments to {input.input1} using picard"
    shell:
        "picard AddCommentsToBam "
        "I={input.input1} "
        "O={output.output1} "
        "C=Fantastic_comment"
