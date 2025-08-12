+++
title = "Download Datasets From Highlighter"
description = "Download a Dataset from Highlighter and save it to a local file system in a selected format"
date = 2024-05-20T08:00:00+00:00
updated = 2024-05-20T08:00:00+00:00
draft = false
weight = 100
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

The Highlighter SDK allows you to download your Datasets from your Highlighter
account and save it in some common formats.

When converting to common formats sucs as Coco or Yolo things like `entity_id`
will not be preserved. Only the information nessessary for training will end up 
in the resulting saved dataset. If you want to save a dataset localled and not 
loose this information you must use the `hdf` or `json` format.

## CLI

```console
hl dataset read --help
Usage: hl dataset read [OPTIONS] COMMAND [ARGS]...

Options:
  -i, --dataset-ids TEXT  integet <id> or <id>:<split>
  --page-size INTEGER     [default: 200]
  --help                  Show this message and exit.

Commands:
  coco
  hdf
  yolo
```

**Use `--help` to see the format specific cli options** 

For example, the following will:
  - download dataset 123 and 456
  - save the images to `/my/image/cache/`
   - save the annotations as a `coco` dataset to `my_dataset/`

```console
hl dataset read -i 123:train -i 456:test coco --annotations-dir my_dataset/ --data-file-dir /my/image/cache/

ls my_dataset/
> test.json train.json
```

Use `--help` to see the format specific cli Options

```console
hl dataset read -i 123 yolo --help
```

# Python API

The following will do same download and conversion as in the CLI example

```python
from pathlib import Path
from highlighter.datasets import Dataset 
from highlighter.datasets.formats.coco import CocoWriter
from highlighter import HLClient

client = HLClient.from_env()

train_ds = Dataset.read_highlighter_dataset_assessments(
        client, 123
        )
train_ds.data_files_df.loc[:, "split"] = "train"

test_ds = Dataset.read_highlighter_dataset_assessments(
        client, 456
        )
test_ds.data_files_df.loc[:, "split"] = "test"

combined_ds = Dataset.combine([train_ds, test_ds])

annotations_dir = Path("my_dataset/")
writer = CocoWriter(annotations_dir)
writer.write(combined_ds)

images_dir = Path("/my/image/cache/")
Dataset.download_dataset_files(
        client,
        images_dir,
        combined_ds.data_files_df,
        )
```
