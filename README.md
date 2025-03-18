# Swift-SDL3-Boilerplate

Absolutely Minimal Possible SDL3 integration with Swift.

### Building

Need to use Ninja because Swift is not supported by the basic "Unix Makefiles" generator

- `cmake -S . -B build -G Ninja`
- `cmake --build build`

SDL will probably show a bunch of warnings. They're fine.

### Running

`./build/swift-sdl-boilerplate`


### Environment Setup

#### Dependencies

Inside `dependencies/`:

- `git submodule add https://github.com/libsdl-org/SDL.git`
- Should ideally be pinned to a release tag / commit, but this is MVP.

#### Module Map to call C from Swift

SDL.h is the umbrella header, but it also includes everything else anyway, so we can just:

```
module SDL {
	header "../dependencies/SDL/include/SDL3/SDL.h"
	export *
}
```

#### CMake

Tried to make this as minimal as possible. See comments in CMakeLists.txt for details.
