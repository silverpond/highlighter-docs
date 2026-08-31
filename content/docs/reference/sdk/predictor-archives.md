+++
title = "Package and run predictors"
description = "Build portable predictor archives and use typed prediction results in Highlighter agents."
date = 2026-07-27T08:00:00+00:00
updated = 2026-07-27T08:00:00+00:00
draft = false
weight = 7
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Package model code, resources, and a verified example as one portable artefact."
toc = true
top = false
+++

Highlighter predictor archives bundle the code and resources required for
inference. This keeps model-specific preprocessing and postprocessing with the
model, while an agent capability handles workflow concerns such as cropping,
stream state, and converting predictions to entities or observations.

## Choose a prediction type

A predictor implements the protocol that matches its output:

- `ClassifyPredictor`
- `DetectPredictor`
- `InstanceSegmentPredictor`
- `SemanticSegmentPredictor`
- `OCRPredictor`

Each predictor defines:

```python
@classmethod
def from_archive(cls, archive_path: Path): ...

def predict(self, batch: list[np.ndarray]) -> list[list[SpecificPrediction]]: ...
```

The outer result list must align one-to-one with the input batch. The inner
list contains the predictions for that input. A classifier returns either zero
or one `ClassifyPrediction` in each inner list.

Specific predictions provide `to_annotation`, `add_to_annotation`, and
`to_observation`. Capabilities call these conversion methods after applying
capability-owned behavior such as crop translation.

## Create an archive

Use `TrainingRun.create_artefact` to package and validate a predictor before it
is registered:

```python
from pathlib import Path

from highlighter import hltrain
from highlighter.client.training_runs import TrainingRunArtefactTypeEnum

with hltrain.training_run.read(TRAINING_RUN_ID) as training_run:
    artefact = training_run.create_artefact(
        archive_path=Path("output/predictor.tar.gz"),
        predictor_path=Path("predictor.py"),
        resources={"model": Path("output/model.onnx")},
        build_parameters={"image_size": 512, "class_lookup": class_lookup},
        example_image=example_image,
        expected_output=predictor.predict([example_image]),
        artefact_type=TrainingRunArtefactTypeEnum.OnnxOpset16,
    )
```

The archive contains:

- `manifest.yaml`, including interface version, resource paths, and build parameters
- `predictor.py`
- files under `resources/`
- `example_image.npy`
- `example_output.yaml`

Highlighter validates archive paths and members before importing
`predictor.py`, then loads the packaged predictor and checks that its result for
the example image matches `example_output.yaml`.

> Predictor archives contain executable Python. Only load archives from a
> trusted source. Structural validation prevents unsafe archive paths; it does
> not sandbox predictor code.

## Load an archive in a capability

Built-in detector and classifier capabilities accept predictor archives
through the same model-path parameter used by legacy ONNX models. Archive
detection happens before legacy model-type dispatch, so existing configurations
can migrate by replacing the model path without adding format-specific logic
to the capability.

`YoloBoxClassifier` remains available for existing agent definitions, but new
definitions should use `EntityClassifier` with `predictor_type="yolov8"`.
