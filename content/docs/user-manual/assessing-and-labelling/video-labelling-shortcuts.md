+++
title = "Video Labelling Shortcuts, Tools and Tips"
description = "Boost video annotation efficiency in Highlighter AI with essential keyboard shortcuts, navigation tools, and productivity tips to speed up labelling and streamline workflows."
date = 2025-05-01T08:00:00+00:00
updated = 2025-05-01T08:00:00+00:00
draft = false
weight = 40
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Master video annotation with these essential shortcuts, tools, and productivity tips for Highlighter's video labelling interface."
toc = true
top = false
+++

## Keyboard Shortcuts

### Navigation
- **Spacebar**: Play/pause video
- **Left/Right arrows**: Frame-by-frame navigation
- **Shift + Left/Right**: Jump 1 second
- **Home/End**: Go to start/end of video
- **J/K/L**: Reverse/pause/forward (industry standard)

### Annotation Tools
- **B**: Bounding box tool
- **P**: Polygon tool
- **S**: Segmentation tool
- **E**: Erase tool
- **Esc**: Cancel current annotation

### Workflow Controls
- **Save** button: Save current work
- **Ctrl + Z**: Undo last action
- **Ctrl + Y**: Redo action
- **Tab**: Switch between objects
- **Enter**: Confirm current annotation

## Annotation Tools

### Bounding Box Tool
Use for object detection tasks. Click and drag to create rectangular annotations around objects of interest.

**Best Practices**:
- Keep boxes tight around objects
- Include all visible parts of the object
- Avoid overlapping unless necessary

### Polygon Tool
Ideal for irregular shapes and precise object boundaries.

**Best Practices**:
- Use minimum points necessary for accuracy
- Close polygons by clicking on the first point
- Use smooth, flowing lines for natural objects

### Auto-Segmentation Tool
Leverage AI-assisted segmentation for complex shapes.

**Best Practices**:
- Start with clear, high-contrast objects
- Refine AI suggestions manually when needed
- Use the brush tool for fine-tuning

## Joining Tracks
If multiple tracks are actually for the same entity (in other words, for the same real-world object), you may want to join the tracks together. This process takes any number of separate tracks and joins them together, to result in one continuous tracks. To do this:
- Select the tracks to be joined. To do this, select the first track, hold down the shift key, then select subsequent tracks until they are all selected. Select tracks either in the list in the left side panel (use keyboard shortcut 'l', lower-case L, to open the side panel if it is closed), or in the main panel.
- In the top menu select Edit -> Join Tracks or use shortcut key 'a'.

## Productivity Tips

### Efficient Workflow
1. **Preview First**: Scan through the entire video before starting
2. **Consistency**: Maintain consistent annotation standards
3. **Save Frequently**: Use Ctrl+S regularly to avoid data loss
4. **Batch Similar Objects**: Annotate similar objects in sequence

### Quality Control
- **Review Mode**: Use review mode to check completed annotations
- **Validation**: Verify annotations meet quality standards
- **Feedback Loop**: Use assessment workflows for continuous improvement

### Timeline Navigation
- Use the timeline scrubber for quick navigation
- Set keyframes at important scenes
- Use markers for complex sequences

## Troubleshooting

### Common Issues

**Video Won't Load**
- Check video format compatibility
- Ensure stable internet connection
- Try refreshing the browser

**Annotations Not Saving**
- Verify write permissions
- Check available storage space
- Ensure proper workflow configuration

**Performance Issues**
- Close unnecessary browser tabs
- Use Chrome or Firefox for best performance
- Consider reducing video resolution for complex annotations

### Getting Help
- See [Troubleshooting Annotation Tool](./troubleshooting-annotation-tool/) for more troubleshooting tips.
- Contact support [support@highlighter.ai](mailto:support@highlighter.ai)
- Check system status for service updates
