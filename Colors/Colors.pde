
size(4096,4096);

println(color(0,0,0));
println(color(255,255,255));

loadPixels();
for(int i = 0; i < pixels.length; i++) {
  pixels[i] = -i;
}
updatePixels();
saveFrame();
