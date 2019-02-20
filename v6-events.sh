array=(
# 对内事件
editor.mousedown
editor.mousedown.core
editor.mousedown.out
editor.mousedown.out.core

editor.click
editor.click.core
editor.click.out
editor.click.out.core

editor.edit.apply
editor.edit.cancel

editor.transform.active
editor.transform.resizing
editor.transform.rotating
editor.transform.inactive

editor.dragger.active
editor.dragger.moving
editor.dragger.inactive

editor.drag.active
editor.drag.moving
editor.drag.inactive
editor.drag.customMoving

editor.element.rect.update
editor.element.dblclick

editor.zoom
editor.zoom.before

editor.keyDown
editor.paste
editor.resize
editor.scroll
editor.contextmenu
editor.croper.update

editor.element.picker
editor.highlight.element
editor.image.picker.show

editor.remove
editor.element.loaded
editor.element.error.load
editor.templet.ready

editor.currentRichText.update
editor.groupBounding.reset
editor.groupContent.scale

imageCroper.activeInner
imageCroper.activeOuter
image.cancal.expand

color.history.add
hue.color.change

transform.click
transform.dblclick
transform.drag

# 对外事件，还需要注意 load 与 editor.change 事件
editor-error
editor-layout-loaded
layout.load
templet.ready
editor-templet-loaded
editor-templet-rendered
editor-element-picker
)

for i in "${array[@]}"
do
  find . -type f -not -path "*/node_modules/*" -print | xargs grep "\'$i\'"
done
