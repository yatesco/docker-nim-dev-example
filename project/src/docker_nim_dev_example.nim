import os, zip/zipfiles

# Hello Nim!
echo "Hello, World!"

proc createZip(rootDir: string) =
  let filename = rootDir / "out.gz"
  var z: ZipArchive
  discard open(z, filename, fmWrite)
  for x in walkDirRec(rootDir):
    addFile(z, x, x)
  close z

createZip("../")
