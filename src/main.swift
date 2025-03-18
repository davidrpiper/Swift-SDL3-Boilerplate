import SDL

guard SDL_Init(SDL_INIT_VIDEO) == true else {
    fatalError("SDL could not initialize! SDL_Error: \(String(cString: SDL_GetError()))")
}

print("Hello, SDL3!")
