# WebFileDialog

This plugin allows you to use the browser's open file dialog to read files from the user's file system. It uses the new `JavaScript` features introduced with v3.4.
 
## Usage

The plugin registers a `WebFileDialog` singleton. To open a file, call the `open_file` method on the singleton. This method has three optional parameters:

1. `accept`: The file types to accept, in a format allowed by the `accept` attribute of the HTML file input tag. Defaults to `""`, meaning accept anything.
2. `text`: A boolean that indicates whether the opened file should be parsed as text. Defaults to `false`.
3. `multiple`: A boolean that indicates whether to allow the user to select multiple files. Defaults to `false`.

```gdscript
func _on_OpenButton_pressed():
	WebFileDialog.open_file(".jpg,.jpeg")
```

In order to process the opened file, you will need to connect the `file_opened` signal. This signal will be emitted when the user selects a file to open. 

```gdscript
func _ready():
	WebFileDialog.connect("file_opened", self, "_on_file_opened")
```

The signal has two parameters: the filename and the contents of the file. 

If the `text` parameter is set to `true` when calling `open_file`, then the contents will be a String, otherwise the contents will be a PoolByteArray.

If the `multiple` option is set to `true` when calling `open_file`, then this signal could be emitted multiple times, once for each file. 

If the user chooses not to select a file, no signal will be emitted. Your code will need to be written in such a way that allows for this possibility.

```gdscript
func _on_file_opened(filename, contents):
	$VBoxContainer/Label.text = filename
	var img = Image.new()
	img.load_jpg_from_buffer(contents)
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	$VBoxContainer/TextureRect.texture = tex
```

You can also save a file to the user's computer with the `save_file` method. This is just a convenience method for `JavaScript.download_buffer()`. This method accepts three parameters, the last of which is optional:

1. `file`: The name of the file, for example `"my_file.txt"`.
2. `content`: The file contents, as either a String or a PoolByteArray.
3. `mime`: The mime type of the file. Defaults to `"application/octet-stream"`.

```gdscript
func _on_SaveButton_pressed():
	WebFileDialog.save_file("filename.txt", "This is some content!", "text/plain")
```