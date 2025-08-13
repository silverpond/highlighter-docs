+++
title = "Upload a Local Dataset via the CLI"
description = "How to upload images and optionally annotations to Highlighter using the CLI"
date = 2024-03-12T08:00:00+00:00
updated = 2024-03-12T08:00:00+00:00
draft = false
weight = 100
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

Sometimes you may want to upload images, and other times you may have a labeled
dataset on disk you want to import to Highlighter. This tutorial takes you through
both options.


## Images Only

### Prerequisites
  
This tutorial expects you to have done the following:

  1. Created [Highlighter Credentials →](../highlighter-credentials/)
  2. Created a Data Source in the Highlighter Web UI, note the Data Source ID from the URL, eg:
  `https://your-account-subdomain.highlighter.ai/data_source/DATASOURCE_ID`


### Upload Images From a Directory

The following will upload all files in `--image-dir` to the `--data-source-id`
provided.

Upon completion, you will also have a local directory `<IMAGE_DIR>_with_hl_ids/` with symlinks mapping the
newly created Highlighter file ids to the original files you uploaded.

```bash
hl image create --data-source-id 123 --image-dir my_images/
```


### Upload Images Listed in a Text File

If you have a text file containing paths to the images you want to upload you can
use the `--file` option.

Each path should be on a new line and should be an absolute path or, they can
be relative paths where `--image-dir` will be prepended to each path in the file.

Upon completion, you will also have a local directory `<IMAGE_DIR>_with_hl_ids/` with symlinks mapping the
newly created Highlighter file ids to the original files you uploaded.

```
# images.txt
images/00.jpg
images/01.jpg
images/02.jpg
```

```bash
# Upload images with paths in file
hl image create --data-source-id 123 --file images.txt

# Upload images with paths foo/PATH_FROM_TXT_FILE
hl image create --data-source-id 123 --file images.txt --image-dir foo
```

### Upload a Dataset from a Coco JSON File

If you have a coco dataset json file you can use the `--file` option.

If needed you can use `--image-dir` to append a directory to the `file_name`s
in the coco image records.

Upon completion you will also have a duplicate coco json `<COCO_FILENAME>_with_hl_ids.json` file with the `.images[].file_name` values updated to use the newly created Highlighter file ids

```bash
# Upload images located at foo/image_dir/FILENAME with paths image_dir/FILENAME listed in coco.json
hl image create --data-source-id 123 --file coco.json --image-dir foo
```

## Images And Observations

If you have an existing labelled dataset you can upload the images and 
the labels as follows.

**Note: Coco Bounding Box or Polygon segmentation are the only formats supported by the CLI at the moment**

### Prerequisites
  
This tutorial expects you to have done the following:

  1. Created [Highlighter Credentials](../../reference/sdk/highlighter-credentials/)
  2. Created a Data Source in the Highlighter Web UI, note the ID from the URL, eg:
  `https://your-account-subdomain.highlighter.ai/data_source/DATASOURCE_ID`
  4. Create the Object Classes of the same name in Highlighter
  3. Created an Assessment Workflow in Highlighter, note the ID from the URL, eq:
  `https://your-account-subdomain.highlighter.ai/projects/PROCESS_ID`
  5. Added the Object Classes to the Assessment Workflow
  6. Found your Highlighter User Id

### Coco Dataset

Example directory structure

```
annotations/
  train.json
  ...
images/
  ...
```

```bash
# Upload the images. After this you should have a duplicate of train.json
# containing the new Highlighter file ids train_with_hl_ids.json
hl image create --data-source-id 123 \
  --file annotations/train.json \
  --image-dir images

# Upload the labels in the dataset to an Assessment Workflow
hl submission create-from-dataset \
  --dataset-format coco \
  --data-path annotations/train_with_hl_ids.json \
  --user-id ### \
  --process-id ### \
  --data-source-id ###
```

