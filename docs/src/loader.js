const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");

function resizeCanvasToContainer(canvas) {
  const container = canvas.parentNode;
  const width = container.clientWidth;
  const height = container.clientHeight;

  canvas.style.width = width + "px";
  canvas.style.height = height + "px";

  canvas.width = width; //actual resolution
  canvas.height = height;
}

Module.onRuntimeInitialized = function() {
  const initParticles = Module.cwrap("init_particles", "void", ["number", "number", "number"]);
  const updateParticles = Module.cwrap("update_particles", "void", ["number", "number"]);
  const getParticles = Module.cwrap("get_particles", "number", []);
  const getLines = Module.cwrap("get_lines", "number", []);
  const getLineCount = Module.cwrap("get_line_count", "number", []);
  const generateLines = Module.cwrap("generate_lines", "void", []);
  
  resizeCanvasToContainer(canvas);

  particle_count = 300;

  const container = canvas.parentNode;
  const width = container.clientWidth;
  const height = container.clientHeight;

  initParticles(width, height, particle_count);

  function draw(){
    updateParticles(width, height);

    const ptr = getParticles();

    generateLines();

    const line_ptr = getLines();

    ctx.clearRect(0, 0, width, height);

    for (let i = 0; i < particle_count; ++i) {
      const base = ptr / 4 + i * 4;
      const x = Module.HEAPF32[base];
      const y = Module.HEAPF32[base + 1];

      ctx.beginPath();
      ctx.arc(x, y, 2, 0, Math.PI * 2);
      ctx.fillStyle = 'white';
      ctx.fill();
    }

    for (let i = 0; i < getLineCount(); i++){
      const base = line_ptr / 4 + i * 4;
      const x1 = Module.HEAPF32[base];
      const y1 = Module.HEAPF32[base + 1];
      const x2 = Module.HEAPF32[base + 2];
      const y2 = Module.HEAPF32[base + 3];

      ctx.beginPath();
      ctx.moveTo(x1, y1);
      ctx.lineTo(x2, y2);
      ctx.strokeStyle = 'white';
      ctx.stroke();
    }
    requestAnimationFrame(draw);
  }

  

  draw();
};
