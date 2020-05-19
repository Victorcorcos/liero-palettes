* [Home](/README.md)
* [Importing palettes into GIMP](/doc/import_palettes.md)
* [Applying a palette to an image color map](/doc/set_color_map.md)
* Opening Liero levels (.lev files) in GIMP

## Opening Liero levels (.lev files) in GIMP

Go to `File` → `Open`

In the file dialog enable `Show All Files` and select your .lev file.

Before opening, manually select `Raw image data` as the file type.

![Indexed mode](/screenshots/file-open-dialog.png)

In the **Load image from Raw Data** dialog use these parameters:

* **Image Type**: Indexed
* **Offset**: 0
* **Width**: 504
* **Height**: 350

![Indexed mode](/screenshots/load-raw-image-dialog.png)

Once loaded the .lev file will be show in grayscale. See [applying a palette to
an image color map](/doc/set_color_map.md) to change it back to the Liero palette.
