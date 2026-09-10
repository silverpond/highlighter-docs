+++
title = "Predictor Archives"
description = "Build and run typed Highlighter predictor archives."
date = 2026-07-17T00:00:00+10:00
updated = 2026-07-17T00:00:00+10:00
draft = false
weight = 120
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Build a version 2 predictor archive before deployment, then load it from a typed capability."
toc = true
top = false
+++

Predictor archives package model resources and metadata for the Highlighter Python SDK. Archive construction happens before an agent runs; the runtime only resolves and loads an existing archive.

## Build an archive

Use a registered implementation ID and a model source. The source may be a local file, an HTTPS URL, or a Training Run Artefact ID.

```python
from pathlib import Path

from highlighter.predictors.build import PredictorSource, build_predictor_archive

archive = build_predictor_archive(
    source=PredictorSource(local_path=Path("model.onnx")),
    implementation_id="onnx_yolov8_detector",
    build_options={"num_classes": 3},
)
```

Built-in implementation IDs include detector, classifier, instance-segmentation, RT-DETR, Paddle Mask RT-DETR, and NeuFlow variants. Installed third-party plugins can register additional typed implementations.

## Load an archive at runtime

Configure the matching canonical capability with a `PredictorArchiveReference`. A capability must receive an archive whose declared `PredictorKind` matches its family.

```python
from highlighter.predictors.interface import PredictorKind
from highlighter.predictors.loader import PredictorArchiveReference, load_predictor_archive

predictor = load_predictor_archive(
    PredictorArchiveReference(archive_path=archive),
    expected_kind=PredictorKind.DETECTOR,
)
```

The four canonical capabilities are `DetectorCapability`, `ClassifierCapability`, `InstanceSegmentationCapability`, and `MotionCapability`. Taxonomy UUIDs and confidence thresholds belong to capability configuration, not the archive, so one model archive can be reused across projects.

Configure spatial capabilities with the archive reference and a complete category map. Use `None` for a declared model category that should be ignored:

```python
{
    "predictor_archive": {"archive_path": str(archive)},
    "category_map": {
        0: {
            "attribute_id": "...",
            "attribute_label": "object_class",
            "value_id": "...",
            "value_label": "animal",
        },
        1: None,
    },
}
```

`ClassifierCapability` adds `object_classes` and `clear_prior_observations` for annotation selection and observation replacement. `MotionCapability` uses the same archive reference together with `attribute_id`, `entity_id`, `object_class_id`, `score_type`, and `window_size`; it keeps prepared frames and score windows independently for each stream.

## Version 1 archives

Version 1 archives are not supported. Rebuild the original model resource with `build_predictor_archive` and configure the new archive path. Archives do not contain executable custom-processing modules; predictor code must be installed as a typed plugin.
