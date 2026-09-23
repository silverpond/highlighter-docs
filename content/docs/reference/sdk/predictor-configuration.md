+++
title = "Predictor Configuration"
description = "Configure built-in and bundled predictors in Highlighter SDK agents."
date = 2026-07-28T08:00:00+00:00
updated = 2026-07-28T08:00:00+00:00
draft = false
weight = 7
template = "docs/page.html"

[extra]
lead = "Use one predictor configuration contract across SDK capabilities and archives."
toc = true
top = false
+++

Predictor-backed capabilities use the same three configuration fields:

```json
{
  "training_run_artefact": "model.onnx",
  "predictor_type": "rtdetrv2",
  "predictor_args": {
    "conf_thresh": 0.5
  }
}
```

`training_run_artefact` may be a local path, an HTTP(S) URL, or a Highlighter
Training Run Artefact UUID. URLs and artefacts are resolved through the shared
cache. The legacy `onnx_file`, `model_path`,
`training_run_artefact_id`, and flat model arguments remain supported for
existing pipelines, but new configurations should use the generic fields.

## Built-in predictor types

The SDK provides typed arguments for these built-in predictor types:

| Type | Use |
| --- | --- |
| `resnet` | Image classification |
| `yolov8` | Object detection |
| `rtdetrv2` | Object detection |
| `paddle_mask_rtdetr` | Instance segmentation |
| `neuflowv2` | Frame-pair optical flow for motion measurement |

Typed predictor defaults are applied first. For a predictor archive,
`build_parameters` override those defaults and runtime `predictor_args` override
the archive settings. Unknown arguments are rejected for built-ins. Bundled
predictors receive their opaque arguments and remain responsible for validating
them.

## Predictor archives

Create an archive with exactly one of `predictor_path` or `predictor_type`:

```python
run.create_artefact(
    archive_path="detector.tar.gz",
    predictor_type="rtdetrv2",
    resources={"model": "detector.onnx"},
    build_parameters={"conf_thresh": 0.5},
    example_image=image,
    expected_output=expected_output,
    artefact_type=TrainingRunArtefactTypeEnum.OnnxOpset16,
)
```

Built-in archives use interface version 2 and name the built-in predictor in
their manifest. Version-1 archives containing bundled `predictor.py` code
continue to load. A manifest predictor is authoritative; a legacy
`predictor_type` does not replace it.
