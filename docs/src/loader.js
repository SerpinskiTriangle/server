const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");

Module.onRuntimeInitialized = function() {
  const initParticles = Module.cwrap("init_particles", "void", ["number", "number"]);
  const updateParticles = Module.cwrap("update_particles", "void", ["number", "number"]);
  const getParticles = Module.cwrap("get_particles", "number", []);
  
  particle_count = 1;

  initParticles(100, 100);

  function draw(){
    updateParticles(100, 100);
    const ptr = getParticles();

    ctx.clearRect(0, 0, 100, 100);
    for (let i = 0; i < particle_count; ++i) {
      const base = ptr / 4 + i * 4;
      const x = Module.HEAPF32[base];
      const y = Module.HEAPF32[base + 1];

      ctx.beginPath();
      ctx.arc(x, y, 2, 0, Math.PI * 2);
      ctx.fillStyle = 'white';
      ctx.fill();
    }
    requestAnimationFrame(draw);
  }

  draw();
};
