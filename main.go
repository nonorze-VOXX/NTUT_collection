package main

import (
	"image"
	"image/color"
	"image/png"
	"math/cmplx"
	"os"
	"runtime"
)

const (
	xmin, ymin, xmax, ymax = -2, -2, +2, +2
	width, height          = 1024, 1024
)

func main() {
	img := image.NewRGBA(image.Rect(0, 0, width, height))
	numCPU := runtime.NumCPU()
	runtime.GOMAXPROCS(numCPU)

	type row struct {
		y  int
		rs []color.Color
	}
	rows := make(chan row, height)

	// Worker pool: each worker handles one row at a time.
	for i := 0; i < numCPU; i++ {
		go func() {
			for py := 0; py < height; py++ {
				y := float64(py)/height*(ymax-ymin) + ymin
				rs := make([]color.Color, width)
				for px := 0; px < width; px++ {
					x := float64(px)/width*(xmax-xmin) + xmin
					z := complex(x, y)
					rs[px] = mandelbrot(z)
				}
				rows <- row{py, rs}
			}
		}()
	}

	// Receive and populate the image
	for i := 0; i < height; i++ {
		r := <-rows
		for px, c := range r.rs {
			img.Set(px, r.y, c)
		}
	}
	png.Encode(os.Stdout, img)
}

func mandelbrot(z complex128) color.Color {
	const iterations = 200
	const contrast = 15

	var v complex128
	for n := uint8(0); n < iterations; n++ {
		v = v*v + z
		if cmplx.Abs(v) > 2 {
			return color.Gray{255 - contrast*n}
		}
	}
	return color.Black
}
